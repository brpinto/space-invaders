extends Area2D

signal floor_reached


func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name.contains("Invader"):
		floor_reached.emit()
