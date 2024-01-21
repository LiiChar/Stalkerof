extends RayCast2D

signal ray_collided(collider, target)

var target 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	look_at(target.global_position)
	force_raycast_update()
	if is_colliding():
		emit_signal("ray_collided", get_collider(), target)
