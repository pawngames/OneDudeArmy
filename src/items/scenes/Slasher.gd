extends Upgradeable

var slash_range:float = .8
var attack:float = 10.0

onready var player:Player = get_parent()

func _ready():
	pass

func _process(delta):
	if player.direction.x >= 0:
		$Area2D.rotation = 0
		$Area2D/Sprite.flip_v = false
		$KnifeSprite.scale.x = 1.0
	if player.direction.x < 0:
		$Area2D.rotation = PI
		$Area2D/Sprite.flip_v = true
		$KnifeSprite.scale.x = -1.0
	$KnifeSprite.visible = player.attacking
	pass

func upgrade(percentage:float):
	attack *= 1.0 + percentage
	slash_range *= 1.0 + percentage
	$TimerSlash.wait_time /= 1.0 + percentage
	pass

func add_instance():
	pass

func _on_TimerSlash_timeout():
	player.attacking = true
	$Sound.play()
	$TweenSlash.interpolate_property(
		$KnifeSprite/Knife,
		"rotation_degrees",
		60,
		120,
		0.1,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)
	$TweenSlash.interpolate_property(
		$KnifeSprite/Knife,
		"scale",
		.1,
		.4,
		0.05,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	$TweenSlash.interpolate_property(
		$KnifeSprite/Knife,
		"scale",
		.4,
		.1,
		0.05,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN,
		0.05
	)
	$TweenSlash.interpolate_property(
		$Area2D,
		"scale",
		Vector2.ONE*0.001,
		Vector2.ONE*slash_range,
		0.05,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	)
	$TweenSlash.interpolate_property(
		$Area2D,
		"scale",
		Vector2.ONE*slash_range,
		Vector2.ONE*0.001,
		0.05,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT,
		0.2
	)
	$TweenSlash.start()
	player.get_node("Spritebody").play("Attack")
	pass # Replace with function body.

func _on_Area2D_area_entered(area:Area2D):
	if area.is_in_group("Enemy"):
		area.get_parent().hit(
			position.direction_to(area.position)*25.0, 
			player.attack + attack, true)
	pass

func _on_TweenSlash_tween_all_completed():
	player.attacking = false
	pass
