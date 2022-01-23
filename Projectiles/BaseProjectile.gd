extends KinematicBody2D

export var DAMAGE = 1
export var SPEED = 100
var projectile_direction = Vector2.ZERO

var is_projectile_set = false

var plane_that_shot:KinematicBody2D


func _physics_process(delta):
	if is_projectile_set:
		move_and_collide(projectile_direction * SPEED * delta)
	
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	
func set_projectile(shooter, target):
	plane_that_shot = shooter
	look_at(target)
	
	projectile_direction = target - position
	projectile_direction = projectile_direction.normalized()
	
	is_projectile_set = true


func _on_Area2D_body_entered(body):
	if body.has_method("take_damage") and body != plane_that_shot:
		body.take_damage(DAMAGE)
		#TODO: hit particles
		queue_free()
