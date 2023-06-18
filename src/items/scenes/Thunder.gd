extends Upgradeable

onready var player:Player = get_parent()
export var THUNDER_INST:PackedScene

func _ready():
	pass

func upgrade(percentage:float):
	for inst in $ThunderInsts.get_children():
		inst.attack_time *= 1.0 + percentage
		inst.attack_range *= 1.0 + percentage
		inst.attack_value *= 1.0 + percentage
		inst.max_targets += 1
	pass

func add_instance():
	var inst = THUNDER_INST.instance()
	$ThunderInsts.add_child(inst)
	pass

