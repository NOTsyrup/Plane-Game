extends Camera2D

var timer:float = 0.25

func _process(delta):
	if timer <= 0.25:
		offset = Vector2(rand_range(-1.0, 1.0) * 5, rand_range(-1.0, 1.0) * 5)
		timer += delta	
	if get_tree().get_root().get_node("Main").game_completed:
		offset = Vector2(rand_range(-1.0, 1.0) * 5, rand_range(-1.0, 1.0) * 5)


func _on_Player_cameraShake():
	timer = 0
