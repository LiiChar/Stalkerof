extends CharacterBody2D
class_name Weapon

@export var caliber: Caliber
@export var damage: float
@export var _sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init(texture: String, damage: int):
	self.damage = damage
	var spr = Sprite2D.new()
	spr.scale.x = 0.13
	spr.scale.y = 0.13
	
	var col = CollisionShape2D.new()
	col.disabled = true
	col.shape = CapsuleShape2D.new()
	
	spr.texture = load(texture)
	spr.offset.x = 60
	_sprite = spr
	add_child(spr)
	add_child(col)
	

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
	var dir = Vector2.RIGHT.from_angle(rotation)
	var bullet = Bullet.new(dir, 40, 10, 30, 500, 3)
	var prev_angle = rotation
	var tween = create_tween()
	tween.tween_property(self, "rotation", prev_angle-0.2 , 0.05)
	tween.tween_property(self, "rotation", prev_angle, 0.1)

	add_child(bullet) 
	
	bullet.position = global_position
