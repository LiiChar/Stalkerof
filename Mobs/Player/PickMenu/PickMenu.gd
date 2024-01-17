extends VBoxContainer

var pickable_package = []
var current_label = null:
	set(label):
		if (label != null):
			if (current_label != null):
				current_label.add_theme_font_size_override("font_size", 16)
			label.add_theme_font_size_override("font_size", 18)
		current_label = label

func add_package(package: Package):
	pickable_package.append(package)
	var label = Label.new()
	label.name = package.title
	label.add_theme_font_size_override("font_size", 16)
	label.text = package.title
	add_child(label)
	if (current_label == null):
		current_label = label
	if (not visible):
		show()

func remove_package(package: Package):
	pickable_package.erase(package)
	remove_child(get_node(package.title))
	if len(pickable_package) == 0:
		hide()
		current_label = null
		

func get_items_by_title(title: String):
	for package in pickable_package:
		if (package.title == title):
			return package.items
			
	return null
	
func set_next_current_label():
	if is_visible_in_tree() and len(pickable_package) > 0:
		var index = current_label.get_index()
		if index == (get_child_count() - 1):
			current_label = get_children()[0]
			return

		current_label = get_children()[index + 1]
	
func set_prev_current_label():
	if is_visible_in_tree() and len(pickable_package) > 0:
		var index = current_label.get_index()
		if index == 0:
			current_label = get_children()[(get_child_count() - 1)]
			return

		current_label = get_children()[index - 1]
