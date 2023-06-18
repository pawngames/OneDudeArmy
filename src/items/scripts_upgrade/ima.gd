extends Item

const MAGNET_SCENE = preload("res://src/items/scenes/Magnet.tscn")

func item_effect(level:int):
	if level == 1:
		var inst = MAGNET_SCENE.instance()
		player.add_child(inst)
	else:
		print("improve_magnet")
		player.get_node("Magnet").upgrade(0.1)
	pass
