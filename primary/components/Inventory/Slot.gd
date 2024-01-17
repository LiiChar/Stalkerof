extends Panel

signal slot_entered(slot)
signal slot_exited(slot)

@onready var filter: ColorRect = $ColorRect

var slot_ID
var is_hovering = false
enum State {DEFAULT, TAKEN, FREE}
var state := State.FREE
var is_out_slot = false
var item_stored = null:
	set(item):
		if (item_stored != null):
			remove_child(item_stored)
		if (item != null):
			add_child(item)
		item_stored = item

func set_color(a_state := State.FREE):
	match a_state:
		State.TAKEN:
			filter.color = Color(Color.RED, 0.5)
		State.FREE:
			filter.color = Color(Color.GREEN, 0.0)

func _process(delta):
	
	if get_global_rect().has_point(get_global_mouse_position()):
		if is_hovering == false:
			is_hovering = true
			emit_signal("slot_entered", self)
	else:
		if is_hovering:
			is_hovering = false
			emit_signal("slot_exited", self)
