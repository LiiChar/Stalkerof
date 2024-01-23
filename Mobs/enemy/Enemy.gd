extends Entity
class_name Enemy

@export_category("Enemy")
@export var _sprite: AnimatedSprite2D
@export var _collision: CollisionShape2D
@export var _navigation: NavigationAgent2D
@export var _vision: Area2D

enum STATE {MOVE, CHASE, DEATH, PATROL, EVADE, ATTACK} 
@export var state: STATE = STATE.MOVE
@export var group: Global.GROUPS

var target: Node2D = null
var attack_range: float
var detection_radius: float
var evade_distance: float

var inventory = []
# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta_info()
	
func _process(delta):
	match state:
		STATE.MOVE:
			move_state() 
		STATE.CHASE:
			chase_state()
		STATE.ATTACK:
			attack_state()
		STATE.PATROL:
			patrol_state()
		STATE.EVADE:
			evade_state()
		STATE.DEATH:
			add_to_group("package", true)
			death_state()
	
	move_and_slide()

func move_state():
	pass
	
func attack_state():
	pass

func chase_state():
	if target and global_position.distance_to(target.global_position) > detection_radius:
		state = STATE.MOVE
	elif global_position.distance_to(target.global_position) > attack_range:
		chase()
	else:
		state = STATE.ATTACK
	
func patrol_state():
	pass
	
func evade_state():
	pass

func death_state():
	pass	
	
func chase():
	if not _navigation.is_navigation_finished():
		var movement_delta = speed 
		var current_agent_position = global_position
		var next_path_position = _navigation.get_next_path_position()
		velocity = (next_path_position - current_agent_position).normalized() * movement_delta
	
func set_meta_info():
	add_to_group("entity", true)
	set_collision_layer_value(1, false)
	set_collision_layer_value(4, true)
	set_collision_mask_value(1, true)
	set_collision_mask_value(4, true)
	set_collision_mask_value(2, true)
	set_collision_mask_value(5, true)
	_vision.connect("body_entered", _on_body_entered)
	_vision.connect("body_exited", _on_body_exited)

func _on_body_entered(body: Node2D):
	pass
	
func _on_body_exited(body: Node2D):
	pass

func getRandomPointInRadius(center: Vector2, radius: float) -> Vector2:
	var angle: float = randi_range(0, 2 * PI)  # Random angle in radians
	var distance: float = randi_range(0, radius)  # Random distance within the radius

	var x: float = center.x + distance * cos(angle)
	var y: float = center.y + distance * sin(angle)

	return Vector2(x, y)
