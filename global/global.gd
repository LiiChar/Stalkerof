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
