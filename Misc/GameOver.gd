extends Control



func _on_Menu_pressed():
	get_tree().quit


func _on_Replay_pressed():
	get_tree().reload_current_scene()
