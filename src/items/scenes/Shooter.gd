extends Upgradeable

export var KNIFE_SCENE:PackedScene

onready var player:Player = get_parent()

var count:int = 1
var speed:float = 10.0
var attack:float = 1.0
var pass_through:bool = false

func _ready():
	pass

func _process(delta):
	pass

func add_instance():
	count += 1
	pass

func upgrade(percentage:float):
	speed *= 1.0 + percentage
	attack *= 1.0 + percentage
	$TimerShot.wait_time *= 1.0 - percentage
	pass

func _on_TimerShot_timeout():
	for i in count:
		var scene = KNIFE_SCENE.duplicate(true)
		var inst:Knife = scene.instance()
		var direction:Vector2 = global_position.direction_to(
			player.get_nearest_enemy_pos_to_player())
		inst.global_position = global_position
		inst.attack = float(player.attack) + attack
		inst.speed = speed
		inst.set_direction(direction.normalized())
		inst.rotation = inst.direction.angle() + PI/2
		inst.set_as_toplevel(true)
		add_child(inst)
		yield(get_tree().create_timer($TimerShot.wait_time/(count*2)), "timeout")
	pass
