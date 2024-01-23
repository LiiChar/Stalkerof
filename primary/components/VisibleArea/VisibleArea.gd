extends Area2D
@onready var ray_tscn = preload("res://primary/components/VisibleArea/RayCastVisible.tscn")
@onready var rays = $Rays
@export var player_target: bool = false
#@export var radius: int = 100:
#	set(rds):
#		$CollisionShape2D.shape.radius = rds
#		radius = rds
		
var intersect = []

func _process(delta):
	for target in intersect:
		chech_visible(target)
			
func _on_body_entered(body):
	if "entity" in body.get_groups():
		intersect.push_back(body)

func _on_body_exited(body):
	if body.has_method("hide"):
		intersect.erase(body)
		body.hide()

func chech_visible(target: Node2D):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, target.global_position)
	var result = space_state.intersect_ray(query)
	if result:
		if result.collider == target:
			target.show()
		else:
			target.hide()
#	var ray: RayCast2D = ray_tscn.instantiate()
#	if (player_target):
#		ray.set_collision_mask_value(3, true)
#	ray.set_collision_mask_value(15, true)
#	ray.ray_collided.connect(_on_ray_collided)
#	ray.target = target
#	rays.add_child(ray)
#	intersect.push_back(ray)
#	ray.target_position = target.global_position
#	ray.look_at(target.global_position)


func _on_ray_collided(collide: Node2D, target: Node2D):
	pass
