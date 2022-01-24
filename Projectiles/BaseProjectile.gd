extends KinematicBody2D

export var DAMAGE = 1
export var SPEED = 100
var projectile_direction = Vector2.ZERO
var target:Vector2

var is_projectile_set = false

var plane_that_shot:KinematicBody2D


func _physics_process(delta):
	projectile_direction = position.direction_to(target)
	print(projectile_direction)
	move_and_slide(projectile_direction * SPEED)
	
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	
func set_projectile(shooter, mouse_pos):
	target = mouse_pos
	plane_that_shot = shooter
	look_at(target)
	


func _on_Area2D_body_entered(body):
	if body.has_method("take_damage") and body != plane_that_shot:
		body.take_damage(DAMAGE)
		#TODO: hit particles
		queue_free()
