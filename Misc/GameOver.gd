extends Control



func _on_Menu_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
	Global.enemy_speed_multi = 1
	Global.wave = 0

func _on_Replay_pressed():
	get_tree().reload_current_scene()
	Global.enemy_speed_multi = 1
	Global.wave = 0
