extends Node2D

func _ready() -> void:
	var viewport = get_viewport().get_visible_rect().size
	$Invaders.position.x = viewport.x / 2 - (Globals.invaders_area.x / 2) + 15
	$Invaders.position.y = (($Laser/CollisionShape2D.get_shape().size.x * $Laser.scale.x) * 11) / 2 + (7 * 15)
	#$Invaders.position.y = 712
	$Laser.position.x = viewport.x / 2 - ($Laser/CollisionShape2D.get_shape().size.x * $Laser.scale.x) / 2
	$Laser.position.y = viewport.y - ($Laser/CollisionShape2D.get_shape().size.y * $Laser.scale.y) * 2
	$Shields.position.x = viewport.x / 2 - (Globals.shelters_area.x / 2) 
	$Shields.position.y = viewport.y - (Globals.shelters_area.y * 4)
	$Floor.position = Vector2(0, viewport.y - 50)
	$Floor/CollisionShape2D.shape.extents = Vector2(viewport.x, 5)
	$Floor/ColorRect.size = Vector2(viewport.x, 5)
	$Floor.floor_reached.connect(game_over, CONNECT_ONE_SHOT)
	$Laser.player_dead.connect(game_over, CONNECT_ONE_SHOT)
	
func game_over():
	print("T'ES MORT")
