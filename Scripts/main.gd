extends Node2D

var invaders_count: int
var invaders_init_pos: Vector2
var invaders = preload("res://Scenes/invaders.tscn")

var viewport: Vector2

func _ready() -> void:
	viewport = get_viewport().get_visible_rect().size
	init_invaders()

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
	
func _process(_delta: float) -> void:
	handle_invaders()

func game_over():
	print("T'ES MORT")
	
func init_invaders():
	invaders_count = $Invaders.get_child_count() - 3
	invaders_init_pos = Vector2(
		viewport.x / 2 - (Globals.invaders_area.x / 2) + 15,
		(($Laser/CollisionShape2D.get_shape().size.x * $Laser.scale.x) * 11) / 2 + (7 * 15)
	)

	$Invaders.position = invaders_init_pos

func handle_invaders():
	var invaders_left = $Invaders.get_child_count() - 3
	
	if invaders_count - invaders_left == roundi(invaders_count / 3):
		$Invaders/MoveTimer.wait_time = 0.5
		$Invaders/ShootTimer.wait_time = 1.5
		$Invaders.speed = 1500
	elif invaders_count - invaders_left == roundi(invaders_count / 2):
		$Invaders/MoveTimer.wait_time = 0.3
		$Invaders/ShootTimer.wait_time = 1.0
		$Invaders.speed = 2000
		
	if invaders_left == 0:
		var invaders_instance = invaders.instantiate()
		invaders_instance.name = "Invaders"
		add_child(invaders_instance)
		init_invaders()
		
		
