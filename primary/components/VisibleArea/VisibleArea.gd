extends Area2D

signal body_visibled(body: Entity, vision: bool)

@onready var collision: CollisionShape2D = $CollisionShape2D

var radius: int:
	set(rad):
		collision.shape.radius = radius
		radius = rad
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
			emit_signal("body_visibled", body, false)
		intersect.erase(body)

func chech_visible(target: Entity):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, target.global_position)
	var result = space_state.intersect_ray(query)
	if result:
		if result.collider == target:
			emit_signal("body_visibled", target, true)
		else:
			emit_signal("body_visibled", target, false)
	else:
		emit_signal("body_visibled", target, false)
