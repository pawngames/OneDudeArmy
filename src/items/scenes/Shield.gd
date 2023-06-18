extends Upgradeable

class_name Shield

export var SHIELD_INST_SCENE:PackedScene

var speed:float = 1.0
var attack:float = 1.0
var shield_count:int = 0

func _ready():
	add_instance()
	pass

func _process(delta):
	for child in get_children():
		child.rotation -= delta*speed
	pass

func _on_Area2D_area_entered(area):
	if area.is_in_group("Enemy"):
		area.get_parent().hit(
			position.direction_to(area.position)*25.0, 
			float(get_parent().level) + attack, 
			false)
	pass

func upgrade(percentage:float):
	speed *= 1.0 + percentage
	attack *= 1.0 + percentage
	pass

func add_instance():
	shield_count += 1
	var inst = SHIELD_INST_SCENE.instance()
	inst.get_node("Area2D").connect("area_entered", self, "_on_Area2D_area_entered")
	add_child(inst)
	var new_angle_degrees:float = 360.0/float(shield_count)
	print(shield_count)
	print(new_angle_degrees)
	var i:int = 0
	for child in get_children():
		child.rotation = 0
		get_children()[i].rotation_degrees = i*new_angle_degrees
		i += 1
	pass
