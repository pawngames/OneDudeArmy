extends KinematicBody2D

class_name Enemy

signal enemy_down(xp_gain)

var COLORS:Array = [
	Color.yellow,
	Color.blue.lightened(0.6),
	Color.blue,
	Color.blue.darkened(.6),
	Color.green.lightened(.6),
	Color.green,
	Color.green.lightened(.6),
	Color.red.lightened(.6),
	Color.red,
	Color.red.darkened(.6),
]

var player:KinematicBody2D = null

export var health:float = 5.0
export var xp_gain:float = 1.0
export var enemy_level:float = 1.0

var enemy_data:EnemyData

var direction:Vector2 = Vector2.ZERO
export var speed:float = 55.0

var player_in_range:bool = false

var elapsed:float = 0.0

func _ready():
	pass

func _process(delta):
	if is_instance_valid(player):
		if !player_in_range:
			if !$Sprite.animation.begins_with("Walk"):
				$Sprite.play("Walk")
			elapsed += delta
			direction = enemy_data.move(
				player.global_position,
				global_position,
				elapsed
			)
		else:
			$Sprite.play("Attack")
	else:
		$Sprite.play("Idle")
	$Sprite.flip_h = direction.x < 0.0
	pass
	
func _physics_process(delta):
	move_and_slide(direction*speed)
	direction = direction.linear_interpolate(Vector2.ZERO, .05)
	pass

func death_timeout():
	queue_free()
	pass

func hit(_direction:Vector2, amount:float, knockback:bool):
	if health <= 0:
		return
	
	health -= amount
	$HealthBar.value = health
	$Label.text = str(int(amount))
	if health <= 0:
		player = null
		emit_signal("enemy_down", xp_gain)
		$Timer.disconnect("timeout", self, "_on_Timer_timeout")
		$Area2D.collision_layer = 0
		$Area2D.collision_mask = 0
		collision_layer = 0
		collision_mask = 0
		direction = Vector2.ZERO
		var coin_scene:PackedScene = load("res://src/items/Coin.tscn").duplicate(true)
		var coin_inst:Node2D = coin_scene.instance()
		get_parent().add_child(coin_inst)
		coin_inst.global_position = global_position
		coin_inst.set_value((enemy_level*6/100))
		$Timer.connect("timeout", self, "death_timeout")
		$Timer.start(1.0)
		$Sprite.visible = false
		$Shadow.visible = false
		$Label2.visible = false
		$Splat.visible = true
		return
	
	$Tween.interpolate_property(
		$Sprite,
		"modulate",
		Color.red,
		Color.white,
		0.3,
		Tween.TRANS_BACK,
		Tween.EASE_IN_OUT
	)
	$Tween.interpolate_property(
		$Label,
		"modulate",
		Color.white,
		Color.transparent,
		1.0,
		Tween.TRANS_BACK,
		Tween.EASE_IN_OUT
	)
	$Tween.interpolate_property(
		$HealthBar,
		"modulate",
		Color.white,
		Color.transparent,
		1.0,
		Tween.TRANS_BACK,
		Tween.EASE_IN_OUT
	)
	$Tween.interpolate_property(
		$Label,
		"rect_position",
		Vector2(-20, -28),
		Vector2(-20, -50),
		1.0,
		Tween.TRANS_BACK,
		Tween.EASE_IN_OUT
	)
	$Tween.start()
	if knockback:
		direction -= direction*20.0
	pass

func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		player_in_range = true
		$Timer.start()
	pass

func _on_Area2D_area_exited(area):
	if area.is_in_group("Player"):
		player_in_range = false
		$Timer.stop()
	pass

func _on_Timer_timeout():
	if is_instance_valid(player):
		player.hit(enemy_data.attack*enemy_level)
		$SoundAttack.play()
	pass

func set_level(level:int):
	enemy_level = level
	health = enemy_data.health*(pow(1.05, level))
	speed = enemy_data.speed*(pow(1.05, level))
	xp_gain = enemy_data.xp_gain*(pow(1.05, level))
	var mat:ShaderMaterial = $Sprite.material.duplicate(true)
	mat.set_shader_param("u_replacement_color", COLORS[level/10])
	$Sprite.material = mat
	$Label2.text = str(level)
	pass

func set_data(enemy_name:String):
	var filename:String = "res://src/enemies/enemy_data/" + \
		enemy_name.to_lower().replace(" ", "_") + \
		".tres"
	print(filename)
	var enemy_res:EnemyData = load(filename)
	enemy_data = enemy_res
	set_sprite(enemy_data.frames, enemy_data.color, enemy_data.offset_y)
	$HealthBar.max_value = enemy_data.health
	$HealthBar.value = enemy_data.health
	health = enemy_data.health
	speed = enemy_data.speed
	xp_gain = enemy_data.xp_gain
	pass

func set_sprite(sprite:SpriteFrames, color:Color, y_offset:float):
	$Sprite.frames = sprite
	$Sprite.offset.y = y_offset
	var mat:ShaderMaterial = $Sprite.material.duplicate(true)
	mat.set_shader_param("u_color_key", color)
	$Sprite.material = mat
	pass

func distance_to_player()->float:
	if is_instance_valid(player):
		return global_position.distance_to(player.global_position)
	return 0.0

func _on_VisibilityNotifier2D_screen_exited():
	$TimerDisposeOffScreen.start(20.0)
	pass

func _on_VisibilityNotifier2D_screen_entered():
	$TimerDisposeOffScreen.stop()
	pass

func _on_TimerDisposeOffScreen_timeout():
	queue_free()
	pass
