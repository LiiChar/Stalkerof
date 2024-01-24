extends EnemyPeople

var target_position: Vector2
var prev_position: Vector2

func _ready():
	target_position = getRandomPointInRadius(global_position, 100)
	prev_position = global_position
	group = Global.GROUPS.BANDIT

func move_state():
	var direction: Vector2 = (target_position - global_position).normalized()
	velocity = direction * speed
	if (global_position.distance_to(target_position) < 10):
		target_position = getRandomPointInRadius(prev_position, 100)

func _on_visible_area_body_visibled(body: Entity, vision: bool):
	if (vision):
		if Global.get_relation(group, body.group) < 40:
			target = body
			state = STATE.CHASE
	else:
		target = null
		state = STATE.MOVE
