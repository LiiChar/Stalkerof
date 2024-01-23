extends Area2D
@export var player_target: bool = false
var intersect = []

func _process(delta):
	for target in intersect:
		chech_visible(target)
			
func _on_body_entered(body):
	if "entity" in body.get_groups():
		intersect.push_back(body)

func _on_body_exited(body):
	if body.has_method("hide"):
		if "entity" in body.get_groups():
			body.hide()
		intersect.erase(body)

func chech_visible(target: Node2D):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, target.global_position)
	var result = space_state.intersect_ray(query)
	if result:
		if result.collider == target:
			target.show()
		else:
			target.hide()
	else:
		target.hide()
