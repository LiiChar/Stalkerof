extends EnemyPeople

func move_state():
	var direction = randi_range(-1, 1) * speed
	
	velocity = Vector2(direction, direction)
