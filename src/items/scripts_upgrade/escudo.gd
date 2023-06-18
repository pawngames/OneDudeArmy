extends Item

const SHIELD_SCENE = preload("res://src/items/scenes/Shield.tscn")

func item_effect(level:int):
	if level == 1:
		var inst = SHIELD_SCENE.instance()
		player.add_child(inst)
	else:
		if level % 2 != 0:
			print("add_shield")
			player.get_node("Shield").add_instance()
		else:
			print("improve_shield")
			player.get_node("Shield").upgrade(level*0.05)
	pass
