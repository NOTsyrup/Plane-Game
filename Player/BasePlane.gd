extends KinematicBody2D

export var PLANE_SPEED = 200 
export var RATE_OF_FIRE = 1
export var LIVES = 5
export var projectile_class:PackedScene
export var UP_collision:RectangleShape2D
export var RIGHT_collision:RectangleShape2D
export var CORNER_collision:RectangleShape2D

var velocity = Vector2(1,0)
var is_cooldown = true


func get_input():
	#only get new velocity if a movement key is pressed
	if Input.is_action_pressed("player_right") or Input.is_action_pressed("player_left") or Input.is_action_pressed("player_up") or Input.is_action_pressed("player_down"):
		velocity = Vector2.ZERO
		if Input.is_action_pressed("player_right"):
			velocity.x += 1
		elif Input.is_action_pressed("player_left"):
			velocity.x -= 1
		if Input.is_action_pressed("player_down"):
			velocity.y += 1
		elif Input.is_action_pressed("player_up"):
			velocity.y -= 1
	#normalize velocity to avoid faster movement towards corners
	velocity = velocity.normalized() * PLANE_SPEED
	
	
func animate():
	var animation
	if velocity.x > 0:
		animation = "Right"
		$Sprite.flip_v = false
		$Sprite.rotation_degrees = 0
		$CollisionShape2D.shape = RIGHT_collision
	else:
		animation = "Left"
		$Sprite.flip_v = false
		$Sprite.rotation_degrees = 0
		$CollisionShape2D.shape = RIGHT_collision
	if velocity.y < 0:
		animation = "Up"
		$Sprite.flip_v = false
		$CollisionShape2D.shape = UP_collision
		if velocity.x > 0:
			$Sprite.rotation_degrees = 45
			$CollisionShape2D.shape = CORNER_collision
		elif velocity.x < 0:
			$Sprite.rotation_degrees = -45
			$CollisionShape2D.shape = CORNER_collision
		else:
			$Sprite.rotation_degrees = 0
	elif velocity.y > 0:
		animation = "Up"
		$CollisionShape2D.shape = UP_collision
		$Sprite.flip_v = true
		if velocity.x > 0:
			$Sprite.rotation_degrees = -45
			$CollisionShape2D.shape = CORNER_collision
		elif velocity.x < 0:
			$Sprite.rotation_degrees = 45
			$CollisionShape2D.shape = CORNER_collision
		else:
			$Sprite.rotation_degrees = 0
	$Sprite.animation = animation
	

func _physics_process(delta):
	get_input()
	animate()
	shoot()
	velocity = move_and_slide(velocity)
	
	
func shoot():
	if Input.is_action_pressed("shoot") and is_cooldown:
		var projectile = projectile_class.instance()
		get_parent().add_child(projectile)
		projectile.rotation = 0
		projectile.position = $ProjectileSpawn.global_position
		projectile.set_projectile(self, get_global_mouse_position())
		
		is_cooldown = false
		$Timer.start()
		
		
func _ready():
	$Timer.wait_time = RATE_OF_FIRE
	$Sprite.play()
	
	
func _on_Timer_timeout():
	is_cooldown = true
	
	
func take_damage(damage):
	LIVES -= damage
	print(LIVES)
	#TODO: play damage animation
	if LIVES <= 0:
		player_death()
		
		
func player_death():
	#TODO: death particles
	queue_free()
