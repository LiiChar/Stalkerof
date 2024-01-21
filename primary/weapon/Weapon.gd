
extends CharacterBody2D
class_name Weapon

@onready var _label: Label = $Label
@onready var _sprite: Sprite2D = $Sprite2D

var fireRate : float = 0.5
var nextFireTime : float = 0
var spread_angel = 0.05
# Переменные отдачи54.565
var recoil : bool = false
var recoilDuration : float = 0.1
var recoilForceFactor : float = 2.0  # Фактор силы отдачи
#var originalPosition : Vector2 = Vector2(0, -6)

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
	_sprite.offset.x = 40
	
func canShoot() -> bool:
	return Time.get_ticks_msec() > nextFireTime
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_direcion_sprite()
	
	if recoil:
		apply_recoil(delta)
	
	if Input.is_action_pressed("attack") and canShoot():
		_fire()
		recoil = true
	
	look_at(lerp(global_position, get_global_mouse_position(), 25 * 100000 * delta))
 
	
func _change_caliber():
	pass     
	
func apply_recoil(delta):
	recoilDuration -= delta
	if recoilDuration <= 0:
		recoilDuration = 0.1
		recoil = false
#		position = originalPosition  # Восстанавливаем оригинальную позицию
		return

	var recoilForce = Vector2(randf_range(-1, 1), randf_range(-1, 0)).normalized() * recoilForceFactor  # Используем randf_range вместо rand_range
	global_position += recoilForce * delta

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
#	if magazin <= 0:
#		return
	if can_shoot == false:
		return
	nextFireTime = Time.get_ticks_msec() + fireRate * 1000
	var rotate_value = randf_range(-spread_angel, spread_angel)
	var dir = Vector2.RIGHT.from_angle(rotation + rotate_value)
	var bullet = Bullet.new(dir , 40 + damage, 10, 30, 500, 3)
	rotation = rotation + (rotate_value * 5)

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
	
