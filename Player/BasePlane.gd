extends KinematicBody2D

export var PLANE_SPEED = 200 
export var RATE_OF_FIRE = 1
export var LIVES = 5
export var projectile_class:PackedScene

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
	
	
func update_look_direction():
	look_at(position + velocity)
	if velocity.x < 0:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false


func _physics_process(delta):
	get_input()
	update_look_direction()
	shoot()
	velocity = move_and_slide(velocity)
	
	
func shoot():
	if Input.is_action_pressed("shoot") and is_cooldown:
		var projectile = projectile_class.instance()
		projectile.set_projectile(self, get_global_mouse_position())
		#TODO: FUNCTION THAT SETS SHOOTER AND MOUSE POSITION WHERE USER CLICKED
		get_parent().add_child(projectile)
		projectile.position = $ProjectileSpawn.global_position
		
		is_cooldown = false
		$Timer.start()
		
		
func _ready():
	$Timer.wait_time = RATE_OF_FIRE
	
	
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
