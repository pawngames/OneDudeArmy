extends Control

export var new_game_path:PackedScene

func _ready():
	pass

func _on_Button_pressed():
	get_tree().change_scene_to(new_game_path)
	pass
