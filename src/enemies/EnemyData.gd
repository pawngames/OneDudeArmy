extends Resource
class_name EnemyData

export var health : int
export var attack : int
export var defense : int
export var speed : float
export var xp_gain : float

export var frames : SpriteFrames
export var offset_y : float
export var color : Color

export var _movement_script:Resource

func move(pos_player:Vector2, actual_pos:Vector2, elapsed:float)->Vector2:
	return _movement_script.movement_rule(
		pos_player,
		actual_pos,
		elapsed
	)
	
