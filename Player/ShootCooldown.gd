extends TextureProgress

func _process(delta):
	rect_position += get_local_mouse_position() + Vector2(-16, 32)
