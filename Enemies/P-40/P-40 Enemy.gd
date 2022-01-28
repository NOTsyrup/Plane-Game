extends KinematicBody2D

export(int) var xSpawnPos
export var lives = 1
export var damage = 1
var can_follow = true

var playerPos:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_tree().get_root().get_node("Main").Player.position + Vector2(rand_range(0, 1280), rand_range(0, 720))
	

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
		$HitParticle.emitting = true
		$AnimatedSprite.hide()
		can_follow = false
		$Timer.start()
		
		
func death():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Player" and can_follow:
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
