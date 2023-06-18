extends Upgradeable

export var TRAP_INST:PackedScene

var attack:float = 10.0

func _ready():
	pass

func _on_TimerTrap_timeout():
	var scene = TRAP_INST.duplicate(true)
	var inst:TrapInst = scene.instance()
	inst.attack = attack
	get_parent().get_parent().add_child(inst)
	inst.global_position = global_position
	inst.animate()
	pass

func upgrade(percentage:float):
	attack *= 1.0 + percentage
	$TimerTrap.wait_time /= 1.0 + percentage
	pass

func add_instance():
	pass
