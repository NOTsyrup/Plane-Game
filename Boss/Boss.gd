extends KinematicBody2D

export var projectile_class:PackedScene
export var lives = 20
export var damage = 1
var can_follow = true
var missile_timer = 0

var playerPos:Vector2


func _ready():
	randomize()
	var random =round(rand_range(1, 2))
	if random == 1:
		position = Vector2(get_tree().get_root().get_node("Main").Player.position.x, 0) + Vector2(-800, rand_range(0, 720))
	elif random == 2:
		position = Vector2(get_tree().get_root().get_node("Main").Player.position.x, 0) + Vector2(800,  rand_range(0, 720))


func _physics_process(delta):
	check_player_death()
	if can_follow:
		playerPos = get_tree().get_root().get_node("/root/Main/Player").position
		look_at(playerPos)
		var velocity = position.direction_to(playerPos) * 200
		if position.distance_to(playerPos) > 5:
			velocity = move_and_slide(velocity)
	else:
		move_and_slide(Vector2.ZERO)
	
	#missile timer
	if missile_timer >= 10 && lives > 0:
		var projectile = projectile_class.instance()
		get_parent().add_child(projectile)
		projectile.position = Vector2(position.x + rand_range(-250, 250), -250)
		missile_timer = 0
	#Undo the comment below to enable missiles with boss
#	missile_timer += delta
	

func take_damage(damage):
	lives -= damage
	get_tree().get_root().get_node("Main").boss_health -= damage
	if lives <= 0:
		rotation = 0
		get_tree().get_root().get_node("Main").game_completed = true
		$BossExplosion.can_explode = true
		can_follow = false
	

func death():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Player" and can_follow and get_parent().can_player_damage():
		body.take_damage(1)
		take_damage(1)
	
	
func check_player_death():
	if get_parent().get_player_lives() <= 0:
		can_follow = false
		rotation = 0
		
