extends EnemyMovement

static func movement_rule(pos_player:Vector2, actual_pos:Vector2, elapsed:float)->Vector2:
	var direction:Vector2 = actual_pos.direction_to(pos_player)
	var angle = direction.angle()
	direction.x += sin(elapsed + angle)
	direction.y += cos(elapsed + angle)/2.0
	return direction
