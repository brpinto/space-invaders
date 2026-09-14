extends Node2D

@export var speed: int = 200

var can_move: bool = false
var direction: int = 1
var viewport: Vector2

func _ready() -> void:
	viewport = get_viewport().get_visible_rect().size	
	$Timer.start()
	Globals.large_invader_size = $LargeInvader/CollisionShape2D.get_shape().size
	var small_size = $SmallInvader/CollisionShape2D.get_shape().size
	var medium_size = $MediumInvader/CollisionShape2D.get_shape().size
	
	var small_invaders = get_tree().get_nodes_in_group("small_invaders")
	var medium_invaders_1 = get_tree().get_nodes_in_group("medium_invaders_1")
	var medium_invaders_2 = get_tree().get_nodes_in_group("medium_invaders_2")
	var large_invaders_1 = get_tree().get_nodes_in_group("large_invaders_1")
	var large_invaders_2 = get_tree().get_nodes_in_group("large_invaders_2")
	
	Globals.invaders_area = Vector2(
		(Globals.large_invader_size.x * $LargeInvader.scale.x + (Globals.large_invader_size.x * $LargeInvader.scale.x) * 0.3) * 11,
		(Globals.large_invader_size.y * $LargeInvader.scale.y + Globals.large_invader_size.y + 15) * 4
	)
	
	medium_invaders_1[0].position.y = (medium_size.y * $MediumInvader.scale.y + medium_size.y + 15)
	medium_invaders_2[0].position.y = ((medium_size.y * $MediumInvader.scale.y) + medium_size.y + 15) * 2
	large_invaders_1[0].position.y = (Globals.large_invader_size.y * $LargeInvader.scale.y + Globals.large_invader_size.y + 15) * 3
	large_invaders_2[0].position.y = (Globals.large_invader_size.y * $LargeInvader.scale.y + Globals.large_invader_size.y + 15) * 4
	
	var i = 1;
	
	while i < 11:
		small_invaders[i].position.x = (small_size.x * $SmallInvader.scale.x + (small_size.x * $SmallInvader.scale.x) * 0.67) * i
		medium_invaders_1[i].position.x = (medium_size.x * $MediumInvader.scale.x + (medium_size.x * $MediumInvader.scale.x) * 0.3) * i
		medium_invaders_1[i].position.y = (medium_size.y * $MediumInvader.scale.y + medium_size.y + 15)
		medium_invaders_2[i].position.x = (medium_size.x * $MediumInvader.scale.x + (medium_size.x * $MediumInvader.scale.x) * 0.3) * i
		medium_invaders_2[i].position.y = ((medium_size.y * $MediumInvader.scale.y) + medium_size.y + 15) * 2
		large_invaders_1[i].position.x = (Globals.large_invader_size.x * $LargeInvader.scale.x + (Globals.large_invader_size.x * $LargeInvader.scale.x) * 0.3) * i
		large_invaders_1[i].position.y = (Globals.large_invader_size.y * $LargeInvader.scale.y + Globals.large_invader_size.y + 15) * 3
		large_invaders_2[i].position.x = (Globals.large_invader_size.x * $LargeInvader.scale.x + (Globals.large_invader_size.x * $LargeInvader.scale.x) * 0.3) * i
		large_invaders_2[i].position.y = (Globals.large_invader_size.y * $LargeInvader.scale.y + Globals.large_invader_size.y + 15) * 4
		i += 1
	
func _process(delta: float) -> void:
	move_invaders(delta)
	pass

func move_invaders(delta: float):
	if can_move and self:
		position.x += direction * delta * speed
		if position.x >= viewport.x - Globals.invaders_area.x + Globals.large_invader_size.x * Globals.large_invader_scale.x - 15:
			position.x = viewport.x - Globals.invaders_area.x + Globals.large_invader_size.x * Globals.large_invader_scale.x - 15
			direction = -1
			position.y += Globals.large_invader_size.y * Globals.large_invader_scale.y
			
		else:
			if position.x <= Globals.large_invader_size.x * Globals.large_invader_scale.x / 2:
				position.x = Globals.large_invader_size.x * Globals.large_invader_scale.x / 2
				direction = 1
				position.y += Globals.large_invader_size.y * Globals.large_invader_scale.y	
		can_move = false
		$Timer.start()

func _on_timer_timeout() -> void:
	can_move = true
