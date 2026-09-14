extends Area2D

signal dead

var viewport: Vector2
var is_last: bool = true
var bomb = preload("res://Scenes/invader-bomb.tscn")

func _ready() -> void:
	$AnimatedSprite2D/MoveTimer.start()
	viewport = get_viewport().get_visible_rect().size
	var calculated_scale = viewport.x * 0.045 / ($CollisionShape2D.get_shape().size.x)
	var small_calculated_scale = viewport.x * 0.035 / ($CollisionShape2D.get_shape().size.x)

	if self.name.contains("Medium") or self.name.contains("Large"):
		self.scale = Vector2(calculated_scale, calculated_scale)
		Globals.large_invader_scale = self.scale
	if self.name.contains("Small"):
		self.scale = Vector2(small_calculated_scale, small_calculated_scale)
	self.get_parent().shooter_defined.connect(_on_shooter_defined)

func _process(delta: float) -> void:
	var raycast = $RayCast2D
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider and collider.name.contains("Invader"):
			is_last = false
			$ShootTimer.stop()

	else:
		add_to_group("shooter")

func shoot(shooter):
	var bomb_instance = bomb.instantiate()
	bomb_instance.name = "Bomb" + str(randf())
	bomb_instance.position = shooter.global_position
	get_parent().get_parent().add_child(bomb_instance)

func _on_area_shape_entered(area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not area.name.contains("Beam"):
		return
	$AnimatedSprite2D/MoveTimer.stop()
	$AnimatedSprite2D.play("death")
	if self:
		$DeathTimer.start(0.5)

func _on_timer_timeout() -> void:
	queue_free()
	if self.is_in_group("shooter"):
		remove_from_group("shooter")

func _on_shooter_defined(shooter):
	if self.name == shooter.name:
		shoot(shooter)

func _on_move_timer_timeout() -> void:
	$AnimatedSprite2D.play("walk")
