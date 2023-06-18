extends Node2D

export var enemy_scene:PackedScene

export var p_player:NodePath
onready var player:Player = get_node(p_player)

export var level_curve:Curve

var counter:int = 1

var enemy_list:Array = [
	"Bee",
	"Slime",
	"Slime_Long",
	"Robot",
	"Ghost",
	"Zombie",
]

func _ready():
	pass

func _on_Timer_timeout():
	if !is_instance_valid(player):
		$Timer.stop()
		return
	
	if get_parent().get_child_count() > min(player.level*10, 200):
		print("Too many enemies")
		return
	
	var pos:Vector2 = player.position
	var enemy_number = player.level*3
	var enemies = enemy_list.slice(0, min(player.level, enemy_list.size()))
	var enemy_type = randi() % enemies.size()
	for i in range(enemy_number):
		var distance:float = 500.0 + (randi()%10 - 5)*20
		enemies.shuffle()
		var angle:float = randf()*2*PI
		var enemy_int:Enemy = enemy_scene.duplicate(true).instance()
		var enemy_data:String = enemies[enemy_type]
		enemy_int.set_data(enemy_data)
		enemy_int.global_position = pos + (Vector2.ONE*distance).rotated(angle)
		enemy_int.player = player
		enemy_int.set_level(level_curve.interpolate_baked(float(counter)/200.0) + 1.0)
		get_parent().add_child(enemy_int)
		#enemy_int.connect("enemy_down", player, "xp_gained")
	pass
