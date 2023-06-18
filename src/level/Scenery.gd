extends Node2D

var target:Vector2
onready var targets:Array = $Targets.get_children()

func _ready():
	pass

func _process(delta):
	$Camera2D.global_position = $Camera2D.global_position.linear_interpolate(
		target, 0.003)
	pass

func _on_Timer_timeout():
	$Timer.start(randi()%5 + 1)
	targets.push_back(targets.pop_front())
	target = targets[0].global_position
	pass
