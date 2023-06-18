extends Node2D

class_name Knife

var target:Enemy = null
var direction:Vector2 = Vector2.ZERO
var speed:float = 5.0
var attack:float = 1.0

var pass_through:bool = false
var hit_list:Array = []

func _ready():
	pass

func _process(delta):
	global_position += direction*speed
	pass

func set_direction(_direction:Vector2):
	direction = _direction
	pass

func _on_Area2D_area_entered(area):
	if area.is_in_group("Enemy") and hit_list.find(area) == -1:
		area.get_parent().hit(position.direction_to(area.position)*25.0, attack, false)
		if pass_through:
			hit_list.append(area)
		else:
			queue_free()
	pass

func _on_TimerFree_timeout():
	if is_instance_valid(self):
		queue_free()
	pass
