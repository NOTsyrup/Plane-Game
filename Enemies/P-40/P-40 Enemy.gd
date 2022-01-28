extends KinematicBody2D

export(int) var xSpawnPos

var playerPos:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	var newParent = get_tree().get_root().get_node("Main")
	var oldParent = get_parent()
	get_parent().remove_child(self)
	newParent.add_child(self)
	position = Vector2(xSpawnPos, oldParent.position.y)
	

func _physics_process(delta):
	playerPos = get_tree().get_root().get_node("/root/Main/Player").position
	look_at(playerPos)
	var velocity = position.direction_to(playerPos) * 125
	if position.distance_to(playerPos) > 5:
		velocity = move_and_slide(velocity)
