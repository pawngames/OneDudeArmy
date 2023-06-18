extends Control

export var UPGRADE_ICON:PackedScene

export var p_player:NodePath
onready var player:Player = get_node(p_player)

var coins:int = 0

func _ready():
	if !OS.get_name().begins_with("Android"):
		$joypad.queue_free()
	player.connect("coin_collected", self, "_on_Player_coin_collected")
	pass

func _process(delta):
	$DebugPanel/LblEnemyCount.text = "Enemies: " + str($"../../Scenery".get_child_count())
	pass

func _on_Player_player_down():
	$CenterContainer/Label.text = "You died..."
	$CenterContainer/Label.modulate = Color.white
	pass

func _on_Player_coin_collected():
	coins += 1
	$CoinInd/Label.text = "x " + str(coins)
	pass

func _on_Player_level_up(level, xp_min, xp_max):
	$CenterContainer/UpgradeSelectScreen.show()
	$Control/ProgressBar.min_value = round(xp_min)
	$Control/ProgressBar.max_value = round(xp_max)
	$Control/ProgressBar.update()
	$CenterContainer/Label.text = "Level Up!"
	print(">>>" + str($Control/ProgressBar.min_value) + ":" + str($Control/ProgressBar.max_value) + " = " + str($Control/ProgressBar.value))
	$Tween.interpolate_property(
		$CenterContainer/Label,
		"modulate",
		Color.white,
		Color.transparent,
		1.0,
		Tween.TRANS_EXPO,
		Tween.EASE_IN
	)
	$Tween.start()
	$"../../Scenery/EnemySpawner".counter += 1
	pass

func _on_Player_xp_gain(xp):
	$Control/ProgressBar.value = xp
	print("Value: " + str(xp))
	pass

func _on_UpgradeSelectScreen_upgrade(info):
	if info == null:
		return
	$CenterContainer/UpgradeSelectScreen.visible = false
	get_tree().paused = false
	var node:Item = Item.new()
	node.set_script(load("res://src/items/scripts_upgrade/" + info["script"]))
	node.player = $"../../Scenery/Player"
	node.item_effect(info["level"])
	node.queue_free()
	if !$Panel/Grid.has_node(info["name"]):
		var inst = UPGRADE_ICON.duplicate(true).instance()
		inst.name = info["name"]
		inst.set_info(info)
		$Panel/Grid.add_child(inst)
	else:
		$Panel/Grid.get_node(info["name"]).set_text(str(info["level"]))
	pass


func _on_Button_pressed():
	$CenterContainer/UpgradeSelectScreen.show()
	pass # Replace with function body.
