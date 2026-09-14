extends Area2D

@export var beam_speed: int = 800
 
signal shelter_fired

func _ready() -> void:
	add_to_group("beams")
	var laser = get_parent().get_node("Laser")
	position = laser.position

func _process(delta: float) -> void:
	position += Vector2.UP * delta * beam_speed

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name.contains("Shelter") or area.name.contains("Invader"):
		self.queue_free()
	if area.name.contains("Shelter"):
		shelter_fired.emit()
