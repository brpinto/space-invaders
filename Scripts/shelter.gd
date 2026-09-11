extends Area2D

var viewport: Vector2
var hits: int = 0
func _ready() -> void:
	viewport = get_viewport().get_visible_rect().size
	
	var calculated_scale = viewport.x * 0.06 / ($CollisionShape2D.get_shape().size.x)
	self.scale = Vector2(calculated_scale, calculated_scale)
	var shelter_size = $CollisionShape2D.get_shape().size
	var shelters = get_tree().get_nodes_in_group("shelters")
	
	shelters[0].position.x = (shelter_size.x * self.scale.x) / 2
	#shelters[0].position.y = viewport.y - shelter_size.y * self.scale.y * 4	
	
	Globals.shelters_area = Vector2(
		((shelter_size.x * self.scale.x) * 3) * 3 + (shelter_size.x * self.scale.x),
		(shelter_size.y * self.scale.x)
	)
	
	var i = 1
	while i <= 3:
		shelters[i].position.x = shelters[0].position.x + ((shelter_size.x * self.scale.x) * 3) * i
		#shelters[i].position.y = viewport.y - shelter_size.y * self.scale.y * 4
		i += 1

func _process(delta: float) -> void:
	pass

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if hits < 9:
		hits += 1
		var damage_texture = "res://Assets/shelterDamaged_" + str(hits) + ".png"
		$Sprite2D.texture = load(damage_texture)
	else:
		self.queue_free()
