extends KinematicBody2D

export var DAMAGE = 1
export var SPEED = 500
var projectile_direction = Vector2.ZERO


var plane_that_shot:KinematicBody2D


func _ready():
	projectile_direction = plane_that_shot.velocity.normalized()
	

func _physics_process(delta):
	move_and_collide(projectile_direction * SPEED * delta)
	
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	
func set_shooter(shooter):
	plane_that_shot = shooter
