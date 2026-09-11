extends Area2D
var viewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("walk")
	viewport = get_viewport().get_visible_rect().size
	var calculated_scale = viewport.x * 0.045 / ($CollisionShape2D.get_shape().size.x)
	var small_calculated_scale = viewport.x * 0.035 / ($CollisionShape2D.get_shape().size.x)

	if self.name.contains("Medium") or self.name.contains("Large"):
		self.scale = Vector2(calculated_scale, calculated_scale)
		Globals.large_invader_scale = self.scale
	if self.name.contains("Small"):
		self.scale = Vector2(small_calculated_scale, small_calculated_scale)

		#var calculated_scale = viewport.x * (4.45 / 100) / ($CollisionShape2D.get_shape().size.x)
		#self.scale = Vector2(calculated_scale, calculated_scale)

func _process(delta: float) -> void:
	pass	

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	$AnimatedSprite2D.play("death")
	if self:
		$Timer.start(0.5)
	pass


func _on_timer_timeout() -> void:
	queue_free()
