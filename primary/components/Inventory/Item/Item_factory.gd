extends Node
class_name Item_factory


static func create(txture: String, count: int, item_grids, info: Info) -> Item:
	var item_tscn = preload("res://primary/components/Inventory/Item/Item.tscn")
	var new_item = item_tscn.instantiate()
	new_item.texture = load(txture)
	new_item.count = count
	new_item.info = info
	new_item.item_grids = item_grids
	return new_item
