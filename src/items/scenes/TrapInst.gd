extends Sprite

class_name TrapInst

var attack:float = 10.0
var triggered:bool = false

func _ready():
	pass

func animate():
	var initial_pos = position
	$Tween.interpolate_property(
		self,
		"position",
		initial_pos + Vector2(0, -20),
		initial_pos,
		0.5,
		Tween.TRANS_BACK,
		Tween.EASE_IN_OUT
	)
	$Tween.interpolate_property(
		self,
		"rotation_degrees",
		-20,
		0,
		0.5,
		Tween.TRANS_BOUNCE,
		Tween.EASE_IN_OUT
	)
	$Tween.start()
	pass

func _on_TrapArea_area_entered(area):
	if area.is_in_group("Enemy") and !triggered:
		frame = 1
		triggered = true
		area.get_parent().hit(position.direction_to(area.position)*25.0, attack, false)
		$TimerDispose.start(1.5)
		animate()
	pass

func _on_TimerDispose_timeout():
	queue_free()
	pass
