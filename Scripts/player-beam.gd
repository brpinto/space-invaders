extends Area2D

@export var beam_speed: int = 400

signal shelter_fired
# 1. trouver un moyen de free le laser, pour pas créer 1000 instances
# par exemple quand il arrive aux limites du terrain

# 2. trouver un moyen de limiter le nombre de rayon (normalement 3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var laser = get_parent().get_node("Laser")
	position = laser.position
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2.UP * delta * beam_speed
	pass

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not area.name.contains("Laser"):
		self.queue_free()
	pass # Replace with function body.
