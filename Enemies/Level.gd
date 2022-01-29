extends Node2D

onready var Player = $Player
var enemies_alive = 0

func _ready():
	print(Player)


func get_player_lives():
	return Player.LIVES


func can_player_damage():
	return Player.can_damage

func add_enemy():
	enemies_alive += 1
	
func delete_enemy():
	enemies_alive -= 1
