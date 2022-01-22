extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var newParent = get_tree().get_root().get_node("Main")
	var oldParent = get_parent()
	get_parent().remove_child(self)
	newParent.add_child(self)
	position = oldParent.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
