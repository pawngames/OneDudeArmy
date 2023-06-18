extends Item

const TESLA_SCENE = preload("res://src/items/scenes/Thunder.tscn")

func item_effect(level:int):
	if level == 1:
		var inst = TESLA_SCENE.instance()
		player.add_child(inst)
	else:
		if level % 2 == 0:
			print("add_Thunder")
			player.get_node("Thunder").add_instance()
		else:
			print("improve_Thunder")
			player.get_node("Thunder").upgrade(0.1)
	pass
