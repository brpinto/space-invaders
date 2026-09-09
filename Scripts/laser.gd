extends Area2D

@export var speed: float = 200.0

var beam = preload("res://Scenes/player-projectile.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	var beam_instance = beam.instantiate()
	get_parent().add_child(beam_instance)
