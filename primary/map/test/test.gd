extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var items = [
		Item_factory.create(Global.bullet[0].image, 1, [0, 0], Info.new(Info.TYPE.BULLET, Global.bullet[0].caliber, 'ds', {}, 100))
	]
	var pckg = Package.new('Bullents', items)
	pckg.position = Vector2(0, 50)
	add_child(pckg)
	var items1 = [
		Item_factory.create(Global.bullet[0].image, 1, [0, 0], Info.new(Info.TYPE.BULLET, Global.bullet[0].caliber, 'ds', {}, 100))
	]
	var pckg1 = Package.new('Bullents1', items1)
	pckg1.position = Vector2(5, 50)
	add_child(pckg1)
