extends RayCast2D

signal ray_collided(collider, target)

var target: Node2D
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, target.global_position)
	var result = space_state.intersect_ray(query)
	if result:
		print("Hit at point: ", result.collider.name)
#	look_at(Vector2(target.global_position)
#		force_raycast_update()
#		if is_colliding():
#			emit_signal("ray_collided", get_collider(), target)
#	else:
#		target.hide()
