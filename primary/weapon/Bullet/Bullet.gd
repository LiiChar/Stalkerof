extends CharacterBody2D
class_name Bullet

var ricoshet: int = 0
var damage: float = 0.0
var direction: Vector2 = Vector2(0, 0)
var penetrate: float = 0.0
var time = 2
var speed: int = 0
# Called when the node enters the scene tree for the first time.
func _init(dir: Vector2, dmg, rcst, ptrt, spd, timeout):
	top_level = true
	var spr = Sprite2D.new()
	spr.scale.x = 0.06
	spr.scale.y = 0.06
	add_to_group('bullet')
	var col = CollisionShape2D.new()
	col.disabled = true
	col.shape = CapsuleShape2D.new()
	spr.texture = load("res://assets/entity/weapon/bullet/images/patron-9x39-mm/9-39-BP.png")
	
	add_child(spr)
	add_child(col)
	damage = dmg
	ricoshet = rcst
	penetrate = ptrt
	direction = dir
	speed = spd
	time = timeout
	look_at(dir)
	
func _ready():
	await get_tree().create_timer(time).timeout
	queue_free()

	
func _physics_process(delta):
	
	velocity = direction.normalized() * speed 
	move_and_slide()
