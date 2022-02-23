extends Label

onready var Player = get_node("../../Player")


func _ready():
	text = "Lives: " + str(Player.LIVES)
	
	
func update_lives(lives):
	text = "Lives: " + str(Player.LIVES)
