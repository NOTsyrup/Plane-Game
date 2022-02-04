extends Node2D

signal _randomPos

export (PackedScene) var p40Enemy
var spawnTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawnTimer >= 1:
		emit_signal("_randomPos")
		_spawnEnemy()
		spawnTimer = 0
	spawnTimer += delta

func _spawnEnemy():
	print("enemy spawned")
	var newP40Enemy = p40Enemy.instance()
	get_tree().get_root().get_node("Main").add_child(newP40Enemy)
