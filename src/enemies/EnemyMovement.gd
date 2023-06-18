extends Resource
class_name EnemyMovement

static func movement_rule(pos_player:Vector2, actual_pos:Vector2, delta:float)->Vector2:
	return actual_pos.direction_to(actual_pos)
