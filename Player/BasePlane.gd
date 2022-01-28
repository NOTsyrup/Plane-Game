extends KinematicBody2D

signal cameraShake

export var PLANE_SPEED = 200 
export var RATE_OF_FIRE = 1
export var LIVES = 5
export var projectile_class:PackedScene
export var UP_collision:RectangleShape2D
export var RIGHT_collision:RectangleShape2D
export var CORNER_collision:RectangleShape2D

var velocity = Vector2(1,0)
var is_cooldown = true
var can_take_damage = true
var input = true
var can_damage = true

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
		
	#Check if in water
	if position.y > 575:
		velocity.y = -1
		take_damage(1)
		
	#Check if almost above screen
	if position.y < 10:
		velocity.y = 1	
	
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
	if input:
		get_input()
	animate()
	shoot()
	update_progress_bar()
	velocity = move_and_slide(velocity)
	
	
func shoot():
	if Input.is_action_pressed("shoot") and is_cooldown:
		var projectile = projectile_class.instance()
		get_parent().add_child(projectile)
		projectile.rotation = 0
		projectile.position = $ProjectileSpawn.global_position
		projectile.set_projectile(self, get_global_mouse_position())
		
		is_cooldown = false
		$FireRateTimer.start()
		$ShootSound.play()
		
		
func update_progress_bar():
	if not is_cooldown:
		$TextureProgress.value = $FireRateTimer.time_left
	else:
		$TextureProgress.value = 0
		
		
func _ready():
	$FireRateTimer.wait_time = RATE_OF_FIRE
	$Sprite.play()
	$TextureProgress.max_value = RATE_OF_FIRE
	
	
func _on_Timer_timeout():
	is_cooldown = true
	
	
func take_damage(damage):
	if can_take_damage:
		LIVES -= damage
		print(LIVES)
		$AnimationPlayer.play("Hit")
		can_damage = false
		if LIVES <= 0:
			player_death()
		can_take_damage = false
		$OnHitTimer.start()
		emit_signal("cameraShake")
		$PlayerHitSound.play()
		
		
func player_death():
	$PlayerDeadSound.play()
	$TrailParticles.emitting = false
	$ExplosionParticle.position = Vector2(0,0)
	$ExplosionParticle.emitting = true
	input = false
	velocity = Vector2.ZERO
	$Sprite.visible = false


func _on_OnHitTimer_timeout():
	can_take_damage = true
	can_damage = true
	
