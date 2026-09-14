extends Area2D

signal floor_reached


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.name.contains("Invader"):
		floor_reached.emit()
