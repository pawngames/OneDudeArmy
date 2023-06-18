extends Node2D

export var noise:OpenSimplexNoise
export var map_size:int = 64

func _ready():
	randomize()
	for i in range(-map_size, map_size):
		for j in range(-map_size, map_size):
			$GroundTiles.set_cell(i, j, 0)
			if (noise.get_noise_2d(i, j) > 0.1):
				$RoadTiles.set_cell(i, j, 0)
			if (noise.get_noise_2d(i, j) < -0.3):
				#7 a 15
				var tile = randi()%(15 - 7) + 7
				$Scenery/CollisionTiles.set_cell(i, j, tile)
	for i in 512:
		var tile = randi()%(15 - 7) + 7
		$Scenery/CollisionTiles.set_cell(
			randi()%map_size*2 - map_size, 
			randi()%map_size*2 - map_size, 
			tile)
	for i in 2048:
		var tile = randi()%7
		$Scenery/CollisionTiles.set_cell(
			randi()%map_size*2 - map_size, 
			randi()%map_size*2 - map_size, 
			tile)
	for i in 256:
		var tile = randi()%(37 - 25) + 25
		$Scenery/CollisionTiles.set_cell(
			randi()%map_size*2 - map_size, 
			randi()%map_size*2 - map_size, 
			tile)
	$GroundTiles.update_bitmask_region(
		Vector2(-map_size, -map_size),
		Vector2(map_size, map_size)
	)
	$RoadTiles.update_bitmask_region(
		Vector2(-map_size, -map_size),
		Vector2(map_size, map_size)
	)
	pass
