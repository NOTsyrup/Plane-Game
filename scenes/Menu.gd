extends Control

func _ready():
	pass # Replace with function body.
	
	
func _on_StartButton_pressed():
	get_tree().change_scene("res://TEMPSCENE.tscn")


func _on_CreditsButton_pressed():
	get_tree().change_scene("res://scenes/CreditMenu.tscn")


func _on_MoreInfoButton_pressed():
	get_tree().change_scene("res://scenes/MoreInfoPanel.tscn")
