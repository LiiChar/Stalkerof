extends EnemyPeople

var target_position: Vector2
var prev_position: Vector2

func _ready():
	target_position = getRandomPointInRadius(global_position, 500)
	prev_position = global_position

func move_state():
	var direction: Vector2 = (target_position - global_position).normalized()
	velocity = direction * speed
	if (global_position.distance_to(target_position) < 10):
		target_position = getRandomPointInRadius(prev_position, 200)
