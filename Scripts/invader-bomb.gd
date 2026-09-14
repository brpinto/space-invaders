extends Area2D

@export var bomb_speed: int = 100
 
signal shelter_fired

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += Vector2.DOWN * delta * bomb_speed

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name.contains("Shelter") or area.name.contains("Laser"):
		self.queue_free()
		self.queue_free()
	if area.name.contains("Shelter"):
		shelter_fired.emit()
		
