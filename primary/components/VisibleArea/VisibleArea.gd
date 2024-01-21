extends Area2D
@onready var ray_tscn = preload("res://primary/components/VisibleArea/RayCastVisible.tscn")
@onready var rays = $Rays
@export var player_target: bool = false
#@export var radius: int = 100:
#	set(rds):
#		$CollisionShape2D.shape.radius = rds
#		radius = rds
		
var intersect = []
			
func _on_body_entered(body):
	if "enemy" in body.get_groups():
		chech_visible(body)

func _on_body_exited(body):
	if body.has_method("hide"):
		var item
		for i in intersect:
			if i.target == body:
				item = i
		if item:
			rays.remove_child(item)
			intersect.erase(item)

func chech_visible(target: Node2D):
	var ray: RayCast2D = ray_tscn.instantiate()
	if (player_target):
		ray.set_collision_mask_value(3, true)
	ray.set_collision_mask_value(15, true)
	ray.ray_collided.connect(_on_ray_collided)
	ray.target = target
	rays.add_child(ray)
	intersect.push_back(ray)
	ray.target_position = target.global_position
	ray.look_at(target.global_position)


func _on_ray_collided(collide: Node2D, target: Node2D):
	if collide == target:
		target.show()
	else:
		target.hide()
