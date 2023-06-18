extends Sprite

var active:bool = false

func _ready():
	pass

func activate():
	active = true
	$Particles.emitting = active
	frame = 1
	for i in 20:
		var coin_scene:PackedScene = load("res://src/items/Coin.tscn").duplicate(true)
		var coin_inst:Node2D = coin_scene.instance()
		get_parent().add_child(coin_inst)
		var angle:float = (randf() - 0.5)*2.0*PI
		var radius:float = randf()*50.0 + 20.0
		var rand_position:Vector2 = Vector2(sin(angle), cos(angle))*radius
		print(rand_position)
		coin_inst.global_position = global_position + rand_position
		coin_inst.set_value(randi()%5 + 1)
	$Timer.start(3.0)
	pass

func _on_Timer_timeout():
	if active:
		$Particles.emitting = false
		yield(
			get_tree().create_timer(
				$Particles.lifetime/$Particles.speed_scale), 
				"timeout")
		queue_free()
	pass


func _on_Area2D_area_entered(area):
	if !active and area.is_in_group("Player"):
		activate()
	pass
