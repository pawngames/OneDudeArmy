extends Node2D

var points:int = 20
var _target:Enemy = null

var attack_time:float = 3.0
var attack_range:float = 250.0
var attack_value:float = 10.0
var max_targets:int = 1

func _ready():
	for i in points:
		add_point(1)
	pass

func set_target(target:Enemy):
	_target = target
	pass

func add_point(step:int):
	var new_point:Vector2 = Vector2.ZERO
	new_point.x = $Line2D.points.size()*step
	$Line2D.add_point(new_point)
	pass

func set_values(val_time:float, val_attack:float, val_range:float):
	attack_time = val_time
	$TimerAttack.wait_time = attack_time
	attack_value = val_attack
	attack_range = val_range
	pass

func _on_Timer_timeout():
	if !is_instance_valid(_target) or $Line2D.width <= 0.1:
		$Line2D.visible = false
		return
	
	$Line2D.visible = true
	$Line2D.look_at(_target.global_position)
	var step:int = global_position.distance_to(_target.global_position)/points
	for i in points:
		$Line2D.points[i].x = i*step
	
	for i in range($Line2D.points.size() - 1):
		var width_add = $Line2D.width_curve.interpolate(float(i)/$Line2D.points.size())
		$Line2D.points[i].y = (randi()%10 - 5)*width_add*10
	pass

func _on_TimerAttack_timeout():
	var player:Player = get_parent().get_parent().player
	var enemies = player.get_nearest_enemies_to_player().slice(0, max_targets)
	if enemies.size() > 0:
		enemies.shuffle()
		var possible_target:Enemy = enemies[0]
		if possible_target.global_position.distance_to(
			player.global_position) < attack_range:
			_target = possible_target
		else:
			_target = null
		if is_instance_valid(_target):
			$Sound.pitch_scale = randf() + 0.5
			$Sound.play()
			_target.hit(Vector2.ZERO, attack_value, false)
			$Tween.interpolate_property(
				$Line2D,
				"width",
				30.0, 0.0, 0.3
			)
			$Tween.start()
	pass
