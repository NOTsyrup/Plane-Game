extends TextureProgress


func _process(delta):
	if get_tree().get_root().get_node("Main").boss_alive:
		set_global_position(Vector2(get_global_rect().position.x, 25))
		value = get_tree().get_root().get_node("Main").boss_health
	else:
		value = 0