extends KinematicBody2D

export var DAMAGE = 1
export var SPEED = 100
var projectile_direction = Vector2.ZERO
var target:Vector2

var forward_vector = Vector2(1,0)


var plane_that_shot:KinematicBody2D


func _physics_process(delta):
#	projectile_direction = position.direction_to(target)
	#print(forward_vector)
	move_and_slide(forward_vector.normalized() * SPEED)
	
	
func _ready():
	print(get_parent())
	look_at(target)
	
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	
func set_projectile(shooter, mouse_pos):
	target = mouse_pos
	plane_that_shot = shooter
	
	rotate(shooter.get_angle_to(target))
	forward_vector = target - position
	forward_vector = forward_vector.normalized()


func _on_Area2D_body_entered(body):
	if body.has_method("take_damage") and body != plane_that_shot:
		body.take_damage(DAMAGE)
		$HitParticle.emitting = true
		$Sprite.hide()
		queue_free()