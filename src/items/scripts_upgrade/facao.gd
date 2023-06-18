extends Item

const SLASHER_SCENE = preload("res://src/items/scenes/Slasher.tscn")

func item_effect(level:int):
	if level == 1:
		var inst = SLASHER_SCENE.instance()
		player.add_child(inst)
	else:
		if level % 2 == 0:
			print("add_slash")
			player.get_node("Slasher").add_instance()
		else:
			print("improve_slash")
			player.get_node("Slasher").upgrade(0.1)
	pass
