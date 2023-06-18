extends EnemyMovement

static func movement_rule(pos_player:Vector2, actual_pos:Vector2, elapsed:float)->Vector2:
	return actual_pos.direction_to(pos_player)
