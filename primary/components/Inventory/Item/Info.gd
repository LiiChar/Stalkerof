extends Node
class_name Info


var type: String
var title: String
var description: String
var specifications = {
	"endurance": null,
	"damage": null,
}
var cost: float

func _init(type: String,title: String,description: String, specifications: Dictionary, cost: float):
	self.type = type
	self.title = title
	self.description = description
	self.specifications = specifications
	self.cost = cost
