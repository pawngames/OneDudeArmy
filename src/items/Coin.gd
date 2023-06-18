extends AnimatedSprite

var target:Node2D = null setget set_target, get_target

var values:Dictionary = {
	"tiers" : [
		{"anim":"1_coin_bronze.tres",},
		{"anim":"2_coin_silver.tres",},
		{"anim":"3_coin_gold.tres",},
		{"anim":"4_coin_ametist.tres",},
		{"anim":"5_coin_jade.tres",},
		{"anim":"6_coin_ruby.tres",},
	],
}

var coin_value:int = 1

func _ready():
	pass

func _process(delta):
	if is_instance_valid(target):
		global_position += global_position.direction_to(
			target.global_position).normalized()*5.0
	pass

func set_value(value:int):
	coin_value = value + 1
	frames = load("res://src/items/coin_anim/" + values["tiers"][value]["anim"])
	pass

func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		(area.get_parent() as Player).collect_coin(coin_value)
		$Sparks.emitting = true
		$TimerCollected.start($Sparks.lifetime + 0.1)
		$Shadow.self_modulate = Color.transparent
		self_modulate = Color.transparent
		$Collected.play()
	pass

func _on_TimerCollected_timeout():
	queue_free()
	pass

func _on_TimerVanish_timeout():
	queue_free()
	pass

func set_target(new_value):
	target = new_value

func get_target():
	return target

