extends Item

const SHOOTER_SCENE = preload("res://src/items/scenes/Shooter.tscn")

func item_effect(level:int):
	if level == 1:
		var inst = SHOOTER_SCENE.instance()
		inst.position.y = -20
		player.add_child(inst)
	else:
		if level % 2 != 0:
			print("add_knife")
			player.get_node("Shooter").add_instance()
		else:
			print("improve_knife")
			player.get_node("Shooter").upgrade(0.02)
	pass
