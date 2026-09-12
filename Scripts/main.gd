extends Node2D

var viewport: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport = get_viewport().get_visible_rect().size
	$Invaders.position.x = viewport.x / 2 - (Globals.invaders_area.x / 2) + 15
	#$Invaders.position.y = (($Laser/CollisionShape2D.get_shape().size.x * $Laser.scale.x) * 11) / 2 + (7 * 15)
	$Invaders.position.y = 712
	$Laser.position.x = viewport.x / 2 - ($Laser/CollisionShape2D.get_shape().size.x * $Laser.scale.x) / 2
	$Laser.position.y = viewport.y - ($Laser/CollisionShape2D.get_shape().size.y * $Laser.scale.y) * 2
	$Shields.position.x = viewport.x / 2 - (Globals.shelters_area.x / 2) 
	$Shields.position.y = viewport.y - (Globals.shelters_area.y * 4)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
