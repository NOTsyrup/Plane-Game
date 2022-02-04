extends Control

func _ready():
	pass # Replace with function body.

func _on_ReturntButton_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
	

func _on_QuitButton_pressed():
	get_tree().quit()
