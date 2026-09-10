extends Node2D
var can_move = true
var direction = 1
var speed = 200
var sprite_size

#162
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_size = $Area2D2/CollisionShape2D.get_shape().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var viewport = get_viewport().get_visible_rect().size
	var area = $CollisionShape2D.get_shape().size
	if can_move:
		position.x += direction * delta * speed
		if position.x >= viewport.x - area.x:
			position.x = viewport.x - area.x
			position.y += sprite_size.y
			direction = -1
		else:
			if position.x <= 13:
				position.x = 13
				position.y += sprite_size.y
				direction = 1
				
		can_move = false
		$Timer.start()


func _on_timer_timeout() -> void:
	can_move = true
	pass # Replace with function body.
