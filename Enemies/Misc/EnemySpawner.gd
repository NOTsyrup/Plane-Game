extends Node2D

signal _randomPos

export (PackedScene) var p40Enemy
export (PackedScene) var boss
var spawnTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawnTimer >= 1 and get_tree().get_root().get_node("Main").enemies_alive < 12:
		get_tree().get_root().get_node("Main").add_enemy()
		emit_signal("_randomPos")
		_spawnEnemy()
		spawnTimer = 0
	spawnTimer += delta
	
	if (get_tree().get_root().get_node("Main").boss_alive == false && get_tree().get_root().get_node("Main").enemies_killed >= 1):
		get_tree().get_root().get_node("Main").add_child(boss.instance())
		print("Boss spawned")
		get_tree().get_root().get_node("Main").boss_alive = true

func _spawnEnemy():
	var newP40Enemy = p40Enemy.instance()
	get_tree().get_root().get_node("Main").add_child(newP40Enemy)
