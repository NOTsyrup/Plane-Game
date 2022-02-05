extends TextureProgress

var enemies_left_to_kill = 50

func _process(delta):
	if get_tree().get_root().get_node("Main").boss_alive:
		visible = false
		get_parent().find_node("BossHealth").visible = true
	else:
		set_global_position(Vector2(get_global_rect().position.x, 25))
		value = get_tree().get_root().get_node("Main").enemies_killed
