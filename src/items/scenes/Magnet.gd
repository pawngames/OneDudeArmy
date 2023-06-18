extends Upgradeable

func _ready():
	pass

func upgrade(percentage:float):
	var radius:float = ($MagnetArea/CollisionShape2D.shape as CircleShape2D).radius
	($MagnetArea/CollisionShape2D.shape as CircleShape2D).radius *= 1.0 + percentage*2
	$MagnetArea/ColorRect.rect_size += Vector2.ONE*radius*(1.0 + percentage)
	$MagnetArea/ColorRect.rect_position -= Vector2.ONE*radius*(1.0 + percentage)/2
	pass

func _on_MagnetArea_area_entered(area):
	if area.is_in_group("Coin"):
		area.get_parent().set_target(get_parent())
	pass
