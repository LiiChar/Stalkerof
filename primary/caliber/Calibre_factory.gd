extends Node

class_name CallibreFactory
# defaults to inheriting Reference. We never instantiate anyway though.

const CaliberThcn = preload("res://primary/caliber/Caliber.tscn")

static func create(name: String, image: String, damage_body: int, damage_armor: int, class_armor: float, speed: int, ricochet: float) -> Caliber:
	var caliber = CaliberThcn.instance()
	caliber.caliber = name
	caliber.image = image
	caliber.damage_body = damage_body
	caliber.damage_armor = damage_armor
	caliber.class_armor = class_armor
	caliber.speed = speed
	caliber.ricochet = ricochet
	return caliber

