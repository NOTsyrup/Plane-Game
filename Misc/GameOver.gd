extends Control



func _on_Menu_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")


func _on_Replay_pressed():
	get_tree().reload_current_scene()
