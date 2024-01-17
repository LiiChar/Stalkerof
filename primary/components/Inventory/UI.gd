extends Control
class_name UI

signal inventory_trade(item, append: bool)

signal out_inventory_changed(items)

@onready var inventory: GridContainer = $ScrollContainer/InventoryConainer
@onready var OuterInventory: GridContainer = $OuterContainer/InventoryConainer
@onready var helmet: Panel = $VBoxContainer/HBoxContainer/VBoxContainer3/HBoxContainer/Helmet
@onready var first_weapon: Panel = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer3/FirstWeapon
@onready var secont_weapon: Panel = $VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/SecondWeapon
@onready var armor: Panel = $VBoxContainer/HBoxContainer/VBoxContainer3/HBoxContainer2/Armor
@onready var slote_scene = preload("res://primary/components/Inventory/Slot.tscn") 

var holding_item: Item = null    
var is_out_holding_item = false
var can_place = false
var current_slot = null
var icon_ancor: Vector2

var size_i: int = 88          
var out_item = []
var items = []
		
var armament = {
	"first_weapon": null,
	"secont_weapon": null,
	"pistol": null,
	"armor": null,
	"helmet": null,
	"package": null,
}:
	set(value):
		for armo in value:
			self[armo].add_child(value[armo])
			armament[armo] = value[armo]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(size_i):
		create_slot()
	hide()
	
func _process(delta):
	if holding_item:
		if Input.is_action_just_pressed("attack"):
			place_item.call_deferred()
	else:
		if Input.is_action_just_pressed("attack"):
			if 	$ScrollContainer/InventoryConainer.get_global_rect().has_point(get_global_mouse_position()):
				pick_item()
			if 	$OuterContainer/InventoryConainer.get_global_rect().has_point(get_global_mouse_position()):
				pick_item()
		
func create_slot():
	var new_slot = slote_scene.instantiate()
	new_slot.is_out_slot = false
	new_slot.slot_ID = items.size()
	inventory.add_child(new_slot)
	items.push_back(new_slot)
	new_slot.slot_entered.connect(_on_slot_mouse_entered)
	new_slot.slot_exited.connect(_on_slot_mouse_exited)
	
func create_out_slot():
	var new_slot = slote_scene.instantiate()
	new_slot.is_out_slot = true
	new_slot.slot_ID = out_item.size()
	OuterInventory.add_child(new_slot)
	out_item.push_back(new_slot)
	new_slot.slot_entered.connect(_on_slot_mouse_entered)
	new_slot.slot_exited.connect(_on_slot_mouse_exited)
	
func _on_slot_mouse_entered(a_slot):
	current_slot = a_slot
	if (a_slot.state == a_slot.State.FREE):
		can_place = true
#	if holding_item != null:
#
#		else:
#			a_slot.state = a_slot.State.TAKEN
	
func _on_slot_mouse_exited(a_slot):
	clear_grid()
	
func add_out_inventory(items: Array, size):
#	for n in OuterInventory.get_children():
#		OuterInventory.remove_child(n)
	for i in range(size):
		create_out_slot()
	var temp = items
	for item in self.out_item:
		if item.state == item.State.FREE:
			var el = temp.pop_front()
			if el != null:
				item.item_stored = el
				item.state = item.State.TAKEN
			else:
				break
	if temp.size() > 0:
		# Выбрасывание предмета
		pass			

func create(items, armament):
	var temp = items
	for item in self.items:
		if item.state == item.State.FREE:
			var el = temp.pop_front()
			if el != null:
				item.item_stored = el
				item.state = item.State.TAKEN
			else:
				break
	if temp.size() > 0:
		# Выбрасывание предмета
		pass			
	
	if (armament != null):
		self.armament = armament

func clear_grid():
	for item in items:
		item.set_color()
	if len(out_item) > 0:
		for item in out_item:
			item.set_color()	

func place_item():
	if can_place == false:
		return
	if current_slot.state == current_slot.State.TAKEN:
		return 
	
	if is_out_holding_item:
		if current_slot.is_out_slot == false:
			emit_signal("inventory_trade", holding_item, true)
	else:
		if current_slot.is_out_slot == true:
			emit_signal("inventory_trade", holding_item, false)
	remove_child(holding_item)
	current_slot.state = current_slot.State.TAKEN
	current_slot.item_stored = holding_item
	current_slot.item_stored.global_position = get_global_mouse_position()
	holding_item._snap_to(current_slot.global_position)
	holding_item = null
	clear_grid()
	
func pick_item():
	if not current_slot or not current_slot.item_stored:
		return
	
	if current_slot.is_out_slot:
		is_out_holding_item = true
	else: 
		is_out_holding_item = false
	holding_item = current_slot.item_stored
	current_slot.item_stored = null
	current_slot.state = current_slot.State.FREE
	add_child(holding_item)
	holding_item.global_position = current_slot.global_position
	holding_item.selected = true
	
