extends Node2D

var viewport: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport = get_viewport().get_visible_rect().size
	$Invaders.position.x = viewport.x / 2 - (Globals.invaders_area.x / 2) + 15
	$Invaders.position.y = Globals.invaders_area.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
