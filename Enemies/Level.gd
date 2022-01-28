extends Node2D

onready var Player = $Player

func _ready():
	print(Player)


func get_player_lives():
	return Player.LIVES


func can_player_damage():
	return Player.can_damage
