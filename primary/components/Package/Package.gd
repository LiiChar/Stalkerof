extends CharacterBody2D
class_name Package

var title
var items: Array = []

func _init(title: String, items: Array):
	add_to_group('package')
	self.title = title
	self.items = items
	var sprite = Sprite2D.new()
	sprite.texture = load("res://assets/entity/weapon/bullet/images/patron-9x39-mm/9-39-BP.png")
	add_child(sprite)

	var col = CollisionShape2D.new()
	var shape = CapsuleShape2D.new()
	col.shape = shape
	set_collision_layer_value(1, false)
	set_collision_layer_value(16, true)
	set_collision_mask_value(16, true)
	add_child(col)
