extends Label


func _ready():
	pass


func _process(delta):
	text = "Score: " + str(get_node("/root/Main").get_score())
