extends Label

var enemies_left_to_kill = 50

func _process(delta):
	enemies_left_to_kill = 30 - get_tree().get_root().get_node("Main").enemies_killed
	text = enemies_left_to_kill as String
	if get_tree().get_root().get_node("Main").boss_alive:
		visible = false
