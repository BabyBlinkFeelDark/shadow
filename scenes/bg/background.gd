extends ParallaxBackground

var BG_velosity=25

func _process(delta: float) -> void:
	scroll_offset.x-= BG_velosity * delta
