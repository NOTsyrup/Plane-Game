extends KinematicBody2D

export var DAMAGE = 3
export var SPEED = 200
var death = false
var can_hit = true
var projectile_direction = Vector2.ZERO
var target:Vector2

var forward_vector = Vector2(1,0)


var plane_that_shot:KinematicBody2D

func _physics_process(delta):
#	projectile_direction = position.direction_to(target)
	#print(forward_vector)
	if can_hit:
		look_at(get_tree().get_root().get_node("Main").Player.position)
		var velocity = position.direction_to(get_tree().get_root().get_node("Main").Player.position) * 300
		if position.distance_to(get_tree().get_root().get_node("Main").Player.position) > 5:
			velocity = move_and_slide(velocity)
	
	
func _ready():
	print(get_parent())
	look_at(target)


func _on_Area2D_body_entered(body):
	if body.has_method("take_damage") and body and can_hit:
		body.take_damage(DAMAGE)
		queue_free()


func _on_Timer_timeout():
	queue_free()
	
