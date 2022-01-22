extends KinematicBody2D

export var DAMAGE = 1
export var SPEED = 500
var projectile_direction = Vector2.ZERO

#Must have node named "Player" in scene
onready var shooter = get_parent()


func _ready():
	projectile_direction = shooter.velocity.normalized()
	

func _physics_process(delta):
	move_and_collide(projectile_direction * SPEED * delta)
	
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
