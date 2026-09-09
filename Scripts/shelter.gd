extends Area2D

var hits: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if hits < 9:
		hits += 1
		print(hits)
		var damage_texture = "res://Assets/shelterDamaged_" + str(hits) + ".png"
		$Sprite2D.texture = load(damage_texture)
	else:
		self.queue_free() 
