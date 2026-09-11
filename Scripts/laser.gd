extends Area2D

@export var speed: float = 200.0
var can_shoot = true
var viewport: Vector2

var beam = preload("res://Scenes/player-projectile.tscn")

func _ready() -> void:
	viewport = get_viewport().get_visible_rect().size
	var calculated_scale = viewport.x * 0.06 / ($CollisionShape2D.get_shape().size.x)
	self.scale = Vector2(calculated_scale, calculated_scale)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	var delta = get_process_delta_time()
	if event:
		if event.is_action("ui_left"):
			position += Vector2.LEFT * delta * speed
		if event.is_action("ui_right"):
			position += Vector2.RIGHT * delta * speed
		if event and event.is_action_pressed( "ui_select"):
			shoot()

func shoot():
	if can_shoot:
		var beam_instance = beam.instantiate()
		get_parent().add_child(beam_instance)
		can_shoot = false
		$Timer.start()


func _on_timer_timeout() -> void:
	can_shoot = true
	pass # Replace with function body.
