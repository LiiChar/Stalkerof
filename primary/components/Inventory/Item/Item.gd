extends TextureRect

class_name Item


var count: int = 1:
	set(number):
		$Label.text = str(number)
		count = number
var item_ID
var selected = false
var item_grids
var grid_anchor = null
var max_count 
var info
var type

func _process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func rotate_item():
	for grid in item_grids:
		var temp_y = grid[0]
		grid[0] = -grid[1]
		grid[1] = temp_y
	
	rotation_degrees += 90
	if rotation_degrees >= 360:
		rotation_degrees = 0

func _snap_to(destination: Vector2):
	var tween = get_tree().create_tween()
	
	tween.tween_property(self, 'global_position', destination, 0.15).set_trans(Tween.TRANS_SINE)
	selected = false
