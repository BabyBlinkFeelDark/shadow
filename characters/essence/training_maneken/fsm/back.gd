extends HitBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func hit(value: int = 0):
	$"../../ChaseArea/playerBack/CollisionPolygon2D".disabled = true
	$"../../ChaseArea/playerFront/CollisionPolygon2D".disabled= true
	value -= 10 if value>10 else value
	$"../../VBox/Damage_l".set_text("damn, its back")
	if training_maneken.animation_sprite.is_flipped_h():
		training_maneken.animation_sprite.set_flip_h(false)
		training_maneken.hitboxes.set_scale(Vector2(1,1))
		$"../../ChaseArea/playerBack/CollisionPolygon2D".disabled = false
		$"../../ChaseArea/playerFront/CollisionPolygon2D".disabled= false
		
	else:
		training_maneken.animation_sprite.set_flip_h(true)
		training_maneken.hitboxes.set_scale(Vector2(-1,1))
		$"../../ChaseArea/playerBack/CollisionPolygon2D".disabled = false
		$"../../ChaseArea/playerFront/CollisionPolygon2D".disabled= false
	training_maneken.take_hit(value)
	
