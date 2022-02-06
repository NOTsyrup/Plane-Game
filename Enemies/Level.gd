extends Node2D

onready var Player = $Player
var enemies_alive = 0
var enemies_killed = 0
var boss_health = 20
var boss_alive = false
var game_completed = false

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
