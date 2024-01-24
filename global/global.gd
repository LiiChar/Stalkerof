extends Node

var Global

var time: int = 0

func _ready():
	var timer = Timer.new()
	timer.wait_time = 0.2
	timer.connect('timeout', _on_timer_timeout)
	add_child(timer)
	timer.start()
	
func _on_timer_timeout():
	time += 1
	
enum GROUPS {STALKER, MONSTER, BANDIT, SCIENTIST}
enum RELATION {ENEMIES,
	CONFLICTS,
	DISLIKE,
	CALMNESS,
	INDIFFERENCE,
	UNACQUAINTED,
	UNFAMILIARITY,
	COMPANIONSHIP,
	BROTHERHOOD,
}	

var relation = {
	RELATION.ENEMIES: 0,
	RELATION.CONFLICTS: 10,
	RELATION.DISLIKE: 20,
	RELATION.CALMNESS: 40,
	RELATION.UNACQUAINTED: 50,
	RELATION.UNFAMILIARITY: 60,
	RELATION.COMPANIONSHIP: 80,
	RELATION.BROTHERHOOD: 100,
}
	
var groups_relation = {
	GROUPS.STALKER: {
		GROUPS.BANDIT: 20,
		GROUPS.SCIENTIST: 50,
		GROUPS.MONSTER: 0,
	},
	GROUPS.BANDIT: {
		GROUPS.STALKER: 20,
		GROUPS.SCIENTIST: 20,
		GROUPS.MONSTER: 0,
	},
	GROUPS.SCIENTIST: {
		GROUPS.BANDIT: 30,
		GROUPS.STALKER: 50,
		GROUPS.MONSTER: 0,
	},
	GROUPS.MONSTER: {
		GROUPS.BANDIT: 0,
		GROUPS.STALKER: 0,
		GROUPS.SCIENTIST: 0,
	},
}

func get_relation(your_group: GROUPS, entity_group: GROUPS) -> int:
	if your_group == entity_group:
		return 100
	var relation_group = groups_relation[your_group][entity_group]
	var prev_rel = null
	var relationship: RELATION
	for rel in relation:
		
		if relation_group <= relation[rel]:
			if prev_rel == null:
				relationship = rel
				break
			else:
				relationship = prev_rel
				break
		prev_rel = rel
	return relation[relationship]

var bullet = [
  {
	"caliber": "БП 9x39",
	"image": "res://assets/entity/weapon/bullet/images/patron-9x39-mm/9-39-BP.png",
	"damage_body": "60",
	"damage_armor": "68",
	"class_armor": "4.4",
	"speed": "295",
	"ricochet": "50"
  },
  {
	"caliber": "СПП 9x39",
	"image": "res://assets/entity/weapon/bullet/images/patron-9x39-mm/9-39-SPP.png",
	"damage_body": "67",
	"damage_armor": "56",
	"class_armor": "3.8",
	"speed": "310",
	"ricochet": "40"
  }
]
