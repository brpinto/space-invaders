extends Area2D

@export var speed: float = 200.0

signal player_dead

var can_shoot = true
var life: int = 3
var is_alive = true
var viewport: Vector2
var beam = preload("res://Scenes/player-projectile.tscn")

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	viewport = get_viewport().get_visible_rect().size
	var calculated_scale = viewport.x * 0.06 / ($CollisionShape2D.get_shape().size.x)
	self.scale = Vector2(calculated_scale, calculated_scale)

func _input(event: InputEvent) -> void:
	var delta = get_process_delta_time()
	if event and is_alive:
		if event.is_action("ui_left"):
			position += Vector2.LEFT * delta * speed
		if event.is_action("ui_right"):
			position += Vector2.RIGHT * delta * speed
			
		if event and event.is_action_pressed( "ui_select"):
			shoot()

func shoot():
	if can_shoot:
		var beam_instance = beam.instantiate()
		beam_instance.name = "Beam" + str(randf())
		get_parent().add_child(beam_instance)
		can_shoot = false
		$Timer.start()


func _on_timer_timeout() -> void:
	can_shoot = true

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name.contains("Beam"):
		return
	if area.name.contains("Invader") or area.name.contains("Bomb"):
		$AnimatedSprite2D.play("death")
		is_alive = false
		life_lost()
	
func life_lost():
	life -= 1
	
	if life == 0:
		is_alive = false
		player_dead.emit()
	else:
		$DeathTimer.start()

func _on_death_timer_timeout() -> void:
	position.x = viewport.x / 2 - ($CollisionShape2D.get_shape().size.x * scale.x) / 2
	position.y = viewport.y - ($CollisionShape2D.get_shape().size.y * scale.y) * 2
	await get_tree().create_timer(1.0).timeout
	$AnimatedSprite2D.play("default")
	is_alive = true
