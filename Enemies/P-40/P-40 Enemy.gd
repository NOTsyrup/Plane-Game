extends KinematicBody2D

export(int) var xSpawnPos
export var lives = 1
export var damage = 1
var can_follow = true

var playerPos:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var random =round(rand_range(1, 2))
	if random == 1:
		position = Vector2(get_tree().get_root().get_node("Main").Player.position.x, 0) + Vector2(-700, rand_range(0, 720))
	elif random == 2:
		position = Vector2(get_tree().get_root().get_node("Main").Player.position.x, 0) + Vector2(700,  rand_range(0, 720))
	

func _physics_process(delta):
	check_player_death()
	if can_follow:
		playerPos = get_tree().get_root().get_node("/root/Main/Player").position
		look_at(playerPos)
		var velocity = position.direction_to(playerPos) * 125
		if position.distance_to(playerPos) > 5:
			velocity = move_and_slide(velocity)
	else:
		move_and_slide(Vector2.ZERO)
		

func take_damage(damage):
	lives -= damage
	if lives <= 0:
		$KilledSound.play()
		$HitParticle.emitting = true
		$AnimatedSprite.hide()
		can_follow = false
		$Timer.start()
		
		
func death():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Player" and can_follow and get_parent().can_player_damage():
		body.take_damage(1)
		$HitParticle.emitting = true
		$AnimatedSprite.hide()
		can_follow = false
		$Timer.start()


func _on_Timer_timeout():
	death()
	
	
func check_player_death():
	if get_parent().get_player_lives() <= 0:
		can_follow = false
