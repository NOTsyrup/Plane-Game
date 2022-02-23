extends Control

func _process(delta):
	$ColorRect/Label.text = ("wave " + String(Global.wave) + " complete")
	if visible:
		get_parent().position = Vector2(1280/2, 720/2)


func _on_NextWave_pressed():
	Global.enemy_speed_multi += 0.25
	get_tree().reload_current_scene()


func _on_Menu_pressed():
	get_tree().change_scene("res://Menu.tscn")
	if Global.wave < 8:
		Global.enemy_speed_multi = 1
	Global.wave = 0
	Global.score = 0


func _on_Boss_Death_finished():
	visible = true
	get_parent()._hide_sprite()
