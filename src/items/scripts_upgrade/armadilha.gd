extends Item

const TRAP_SCENE = preload("res://src/items/scenes/TrapSpawner.tscn")

func item_effect(level:int):
	if level == 1:
		var inst = TRAP_SCENE.instance()
		player.add_child(inst)
	else:
		print("improve_trap")
		player.get_node("TrapSpawner").upgrade(level*0.05)
	pass
