extends Node2D

signal invaders_cleared

var invaders_count: int
var invaders_init_pos: Vector2
var invaders_instance
var invaders = preload("res://Scenes/invaders.tscn")

var viewport: Vector2

func _ready() -> void:
	viewport = get_viewport().get_visible_rect().size
	init_invaders()

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
	
func init_invaders():
	invaders_instance = invaders.instantiate()
	add_child(invaders_instance)
	invaders_instance.invaders_cleared.connect(_on_invaders_cleared, CONNECT_ONE_SHOT)
	invaders_count = invaders_instance.get_child_count() - 3
	invaders_init_pos = Vector2(
		viewport.x / 2 - (Globals.invaders_area.x / 2) + 15,
		(($Laser/CollisionShape2D.get_shape().size.x * $Laser.scale.x) * 11) / 2 + (7 * 15)
	)

	var instance_offset = Vector2(0, (Globals.large_invader_size.y * Globals.large_invader_scale.y	* 2) * Globals.level)
	invaders_instance.position = invaders_init_pos + instance_offset

func _on_invaders_cleared() -> void:
	Globals.level += 1
	init_invaders()
