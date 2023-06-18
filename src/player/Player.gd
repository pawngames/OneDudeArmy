extends KinematicBody2D

class_name Player

signal player_down
signal coin_collected
signal xp_gain(xp)
signal level_up(level, xp_min, xp_max)

#editor properties
export var speed:float = 500.0
export var xp_curve:Curve

#movement
var direction:Vector2 = Vector2.ZERO
#char stats
var attack:float = 5.0
var defense:float = 1.0
var health:float = 100.0
var level:int = 0
var xp_points:int = 0

#general vars
var attacking = false
var nearest_enemy_pos:Vector2 = Vector2.ZERO

func _ready():
	$HealthBar.max_value = health
	$HealthBar.value = health
	#for i in range(100):
	#	print("level: " + str(i) + " >> " + str(xp_calc(i)))
	xp_gained(5.0)
	emit_signal("xp_gain", 0)
	pass

func _process(delta):
	if Input.is_action_pressed("ui_down"):
		direction += Vector2.DOWN*delta
	if Input.is_action_pressed("ui_up"):
		direction += Vector2.UP*delta
	if Input.is_action_pressed("ui_left"):
		direction += Vector2.LEFT*delta
	if Input.is_action_pressed("ui_right"):
		direction += Vector2.RIGHT*delta
	if !attacking:
		if direction.length() > 0.1:
			$Spritebody.play("Walk")
		else:
			$Spritebody.play("Idle")
	$Spritebody.flip_h = direction.x < 0.0
	
	if direction.length() > 0.1 and !$Steps.playing:
		$Steps.play()
	elif direction.length() < 0.1:
		$Steps.stop()
	pass

func _physics_process(delta):
	move_and_slide(direction*speed)
	direction = direction.linear_interpolate(Vector2.ZERO, 0.1)
	pass

func collect_coin(value):
	print("coin: " + str(value))
	xp_gained(value)
	emit_signal("coin_collected")
	pass

func hit(amount:float):
	health -= max(0, amount - defense)
	$HealthBar.value = health
	$Tween.interpolate_property(
		$Spritebody,
		"modulate",
		Color.red,
		Color.white,
		0.3,
		Tween.TRANS_BACK,
		Tween.EASE_IN_OUT
	)
	$Tween.start()
	if health <= 0:
		emit_signal("player_down")
		queue_free()
	pass

func xp_gained(amount:int):
	xp_points += amount
	#http://howtomakeanrpg.com/a/how-to-make-an-rpg-levels.html
	var next_level_xp = xp_calc(level + 1)
	if xp_points >= next_level_xp:
		level += 1
		emit_signal(
			"level_up", 
			level,
			xp_calc(level),
			xp_calc(level + 1))
	print("current: " + str(xp_points) + " > next:" + str(next_level_xp))
	emit_signal("xp_gain", xp_points)
	pass

func xp_calc(level:int)->float:
	#return round((4.0 * float(level ^ 3)) / 5.0)
	return xp_curve.interpolate_baked(float(level)/100)*100000

func get_nearest_enemy_pos_to_player()->Vector2:
	var nearest_pos:Vector2 = Vector2.ZERO
	var nearest_enemy:Enemy = null
	for child in get_parent().get_children():
		if child is Enemy:
			if !is_instance_valid(nearest_enemy):
				nearest_enemy = child
				nearest_pos = nearest_enemy.global_position
			
			if child.health > 0:
				if global_position.distance_to(child.global_position) < \
					global_position.distance_to(nearest_enemy.global_position):
					nearest_enemy = child
					nearest_pos = nearest_enemy.global_position
	return nearest_pos

class EnemyListSorter:
	static func sort_ascending(a, b):
		if a.distance_to_player() < b.distance_to_player():
			return true
		return false

func get_nearest_enemies_to_player()->Array:
	var enemy_list:Array = []
	for child in get_parent().get_children():
		if child is Enemy:
			if is_instance_valid(child) and child.health > 0:
				enemy_list.append(child)
	enemy_list.sort_custom(EnemyListSorter, "sort_ascending")
	return enemy_list
