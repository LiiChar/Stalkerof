extends Node
class_name Info

enum TYPE {BULLET, ARMOR, WEAPON, FOOD, MEDKIT}

var type: TYPE
var title: String
var description: String
var specifications = {
	"endurance": null,
	"damage": null,
}
var cost: float

func _init(type: TYPE,title: String,description: String, specifications: Dictionary, cost: float):
	self.type = type
	self.title = title
	self.description = description
	self.specifications = specifications
	self.cost = cost
