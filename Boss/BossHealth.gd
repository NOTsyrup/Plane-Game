extends TextureProgress


func _process(delta):
	if get_tree().get_root().get_node("Main").boss_alive:
		set_global_position(Vector2(get_global_rect().position.x, 25))
		value = get_tree().get_root().get_node("Main").boss_health
		if not $"Stage 1".playing and not $"Stage 2".playing and not $"Stage 3".playing:
			play_music()
	else:
		value = 0
	if get_tree().get_root().get_node("Main").game_completed and not $"Boss Death".playing:
		$"Boss Death".play()
		$"Stage 1".volume_db = -80
		$"Stage 2".volume_db = -80
		$"Stage 3".volume_db = -80
	
func play_music():
	if get_tree().get_root().get_node("Main").game_completed == false:
		if  get_tree().get_root().get_node("Main").boss_health < 15:
			$"Stage 1".volume_db = -80
			$"Stage 2".volume_db = -80
			$"Stage 3".volume_db = 0
			$"Stage 3".play()
		elif get_tree().get_root().get_node("Main").boss_health < 10:
			$"Stage 1".volume_db = -80
			$"Stage 2".volume_db = 0
			$"Stage 3".volume_db = -80
			$"Stage 2".play()
		else:
			$"Stage 1".volume_db = 0
			$"Stage 2".volume_db = -80
			$"Stage 3".volume_db = -80
			$"Stage 1".play()
