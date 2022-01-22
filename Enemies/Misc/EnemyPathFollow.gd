extends PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Enemies__randomPos():
	randomize()
	offset = rand_range(0, 1205)
