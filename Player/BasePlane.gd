extends KinematicBody2D

export var PLANE_SPEED = 200 
var velocity = Vector2(1,0)


func get_input():
	#only get new velocity if a movement key is pressed
	if Input.is_action_pressed("player_right") or Input.is_action_pressed("player_left") or Input.is_action_pressed("player_up") or Input.is_action_pressed("player_down"):
		velocity = Vector2.ZERO
		if Input.is_action_pressed("player_right"):
			velocity.x += 1
		if Input.is_action_pressed("player_left"):
			velocity.x -= 1
		if Input.is_action_pressed("player_down"):
			velocity.y += 1
		if Input.is_action_pressed("player_up"):
			velocity.y -= 1
	#look at direction of movement	
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
	velocity = move_and_slide(velocity)
	
	
	

	