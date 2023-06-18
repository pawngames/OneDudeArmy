extends Camera2D

export var p_target:NodePath
onready var target:Node2D = get_node(p_target)

func _ready():
	pass

func _process(delta):
	if is_instance_valid(target):
		position = position.linear_interpolate(target.position, .1)
	pass
