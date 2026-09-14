extends Area2D

signal dead

var viewport: Vector2
var is_last: bool = true

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

func _process(delta: float) -> void:
	var raycast = $RayCast2D
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider and collider.name.contains("Invader"):
			is_last = false
	else:
		is_last = true
	if is_last:
		#can_shoot() logic => random shoot
		pass 

func _on_area_shape_entered(area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not area.name.contains("Beam"):
		return
	$AnimatedSprite2D.play("death")
	if self:
		$Timer.start(0.5)

func _on_timer_timeout() -> void:
	queue_free()
