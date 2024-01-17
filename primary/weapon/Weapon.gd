extends CharacterBody2D
class_name Weapon

@onready var _label: Label = $Label
@onready var _sprite: Sprite2D = $Sprite2D

var caliber: Caliber
var can_shoot := true
var damage: float
var max_magazin:int;
var magazin: int = 0:
	set(value):
		_label.text = str(value) + "/" + str(max_magazin)
		magazin = value
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(texture: String, damage: int, magazin: int):
	self.damage = damage
	self.magazin = magazin
	self.max_magazin = magazin
	
	_sprite.scale.x = 0.13
	_sprite.scale.y = 0.13
	_sprite.texture = load(texture)
	_sprite.offset.x = 60
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_direcion_sprite()
	look_at(get_global_mouse_position())
	
func _change_caliber():
	pass

func change_direcion_sprite():
	var rtt = global_rotation_degrees
	if (rtt > 0):
		if (rtt > 90):
			_sprite.flip_v = true
			z_index = 4
		else:
			_sprite.flip_v = false
			z_index = 6
	else:
		if (rtt > -90):
			_sprite.flip_v = false
			z_index = 6
		else:
			_sprite.flip_v = true
			z_index = 4
	
func _fire():
	if magazin <= 0:
		return
	if can_shoot == false:
		return
	var dir = Vector2.RIGHT.from_angle(rotation)
	var bullet = Bullet.new(dir, 40 + damage, 10, 30, 500, 3)
	var prev_angle = rotation
	var tween = create_tween()
	tween.tween_property(self, "rotation", prev_angle-0.2 , 0.05)
	tween.tween_property(self, "rotation", prev_angle, 0.1)

	add_child(bullet) 
	magazin -= 1
	bullet.position = global_position

func reload():
	var prev_angle = rotation
	can_shoot = false
	var tween = create_tween()
	tween.tween_property(self, "rotation", 0, 0.5)
	tween.tween_property(self, "rotation", 360, 1)
	await tween.finished
	magazin = max_magazin
	can_shoot = true
	
