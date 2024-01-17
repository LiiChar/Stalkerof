extends Entity

enum STATE {DEATH, REST, TAKE_DAMAGE, MOVE, ATTACK, AIM, INFO, MAP, INVENTORY}

var menu_pick =null
var data: Resource
var has_weapon = false
var is_aim = false
var is_open_info = false
var weight := 0.0
var max_weight := 10.0
var max_health: float = 0
var dir = 1
var look_left = false
var item = [
	Item_factory.create(Global.bullet[0].image, 1, [0, 0], Info.new('bullet', Global.bullet[0].caliber, 'ds', {}, 100)),
	Item_factory.create(Global.bullet[0].image, 1, [0, 0], Info.new('bullet', Global.bullet[0].caliber, 'ds', {}, 100))
]
var armament = {
	"first_weapon": Item_factory.create("res://assets/entity/weapon/vintorez.png", 1,  [1, 0], Info.new("weapon", "Vintorez", "My favorite gun", {}, 1000)),
}
var prev_state = STATE.MOVE
@onready var weapon: Weapon = $Weapon
@onready var inventory = $UI
@onready var animation_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@export var state := STATE.MOVE:
	set(value):
		prev_state = state
		state = value
		
func _ready(): 
	for arm in armament:
		if (arm == 'first_weapon'):
			weapon.init("res://assets/entity/weapon/vintorez.png", 20, 20)
			weapon.position.y = global_position.y - 3
			weapon.z_index = 4
			self.weapon = weapon
	inventory.create(item, armament)
	inventory.connect("inventory_trade", _on_inventory_trader)
	health = max_health
		
func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		state = STATE.ATTACK
	if event.is_action_pressed("move_down") or event.is_action_pressed("move_left") or event.is_action_pressed("move_rigth") or event.is_action_pressed("move_up"):
		state = STATE.MOVE
	if event.is_action_pressed("aim"):
		state = STATE.AIM
	if event.is_action_pressed("info"):
		state = STATE.INFO
	if event.is_action_pressed("inventory"):
		inventory.show()
	if event.is_action_released("inventory"):
		inventory.hide()
	if event.is_action_pressed("attack"):
		if (weapon != null):
			weapon._fire()
	if event.is_action_pressed("list_up"):
		if ($PickMenu.visible):
			$PickMenu.set_prev_current_label()
	if event.is_action_pressed("list_down"):
		if ($PickMenu.visible):
			$PickMenu.set_next_current_label()
	if event.is_action_pressed("use"):
		if ($PickMenu.visible and len($PickMenu.pickable_package)):
			var items = $PickMenu.get_items_by_title($PickMenu.current_label.text)
			if (items != null):
				inventory.add_out_inventory(items, 50)
				inventory.show()
	if event.is_action_pressed("reload"):
		if (weapon != null):
			weapon.reload()
		
func _physics_process(_delta: float) -> void:
	match state:
		STATE.MOVE:
			move_state()
		STATE.REST:
			pass
		STATE.INFO:
			info_state()
		STATE.TAKE_DAMAGE:
			get_damage_state()
		STATE.AIM: 
			aim_state()	
		STATE.DEATH:
			death_state()
	
	move_and_slide()

func idle_state ():
	animation_sprite.play('idle')
	
func move_state (): 
	var direction := Vector2(
		Input.get_axis("move_left", "move_rigth"),
		Input.get_axis("move_up", "move_down")
	)
	
	if direction.length() > 1.0:
		direction = direction.normalized()

	if direction:
		velocity = direction * speed
		if velocity.x > 0:
			
			animation_sprite.play("move_right")
			weapon.z_index = 6
			look_left = false
		elif velocity.x < 0:
			if (weapon != null):
				weapon.z_index = 4
			animation_sprite.play("move_right")
			look_left = true
		elif velocity.y < 0:
			if animation_sprite.sprite_frames.has_animation('move_up'):
				animation_sprite.play("move_up")
		elif velocity.y > 0:
			if animation_sprite.sprite_frames.has_animation('move_down'):
				animation_sprite.play("move_down")	
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		
		if velocity.y == 0 and velocity.x == 0:
			animation_sprite.play("idle")
			
	if (weapon != null and weapon._sprite.flip_v == true):
		animation_sprite.flip_h = true
	else:
		animation_sprite.flip_h = false
	
func death_state ():
	queue_free()
	
func aim_state():
	is_aim = true
	state = prev_state

func info_state():
	is_open_info = true
	state = prev_state#
	
func get_damage_state():
	pass
#	animation_sprite.play("take_damage")
	await animation_sprite.animation_finished
	
func take_damage(dmg: float):
	if ((health - dmg) <= 0):
		state = STATE.DEATH
	else:
		state = STATE.TAKE_DAMAGE
		health -= dmg
		
func set_weapon(weapon: Weapon):
	self.weapon = weapon
	

func _on_item_pick_body_entered(body):
	if body.get_groups()[0] == 'package':
		$PickMenu.add_package(body)


func _on_item_pick_body_exited(body):
	if body.get_groups()[0] == 'package':
		if (body.title == $PickMenu.current_label.text):
			inventory.hide()
		$PickMenu.remove_package(body)
		
func _on_inventory_trader(itm: Item,  append: bool):
	if append:
		item.append(itm)
	else:
		item.erase(itm)
