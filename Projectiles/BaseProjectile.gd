extends KinematicBody2D

export var DAMAGE = 1
export var SPEED = 100
var death = false
var can_hit = true
var projectile_direction = Vector2.ZERO
var target:Vector2
var collateral_hits = 0
onready var Main = get_node("/root/Main")

var forward_vector = Vector2(1,0)


var plane_that_shot:KinematicBody2D

func _physics_process(delta):
#	projectile_direction = position.direction_to(target)
	#print(forward_vector)
	if can_hit:
		move_and_slide(forward_vector.normalized() * SPEED)
	
	
func _ready():
	print(get_parent())
	look_at(target)
	#$Timer.start()
	
	
func set_projectile(shooter, mouse_pos):
	target = mouse_pos
	plane_that_shot = shooter
	
	rotate(shooter.get_angle_to(target))
	forward_vector = target - position
	forward_vector = forward_vector.normalized()


func _on_Area2D_body_entered(body):
	if body.has_method("take_damage") and body != plane_that_shot and can_hit:
		body.take_damage(DAMAGE)
		get_tree().get_root().get_node("Main").enemies_killed += 1
		collateral_hits += 1
	if body.name == "Boss":
		var hit_multiplier
		if collateral_hits > 1:
			hit_multiplier = collateral_hits * 0.5
		else:
			hit_multiplier = 1
		Main.set_score(collateral_hits, hit_multiplier)
		
		queue_free()


#func _on_Timer_timeout():
#	var hit_multiplier
#	if collateral_hits > 1:
#		hit_multiplier = collateral_hits * 0.5
#	else:
#		hit_multiplier = 1
#	print("should call set score")
#	Main.set_score(collateral_hits, hit_multiplier)
#	queue_free()
	
	
func _on_VisibilityNotifier2D_screen_exited():
	var hit_multiplier
	if collateral_hits > 1:
		hit_multiplier = collateral_hits * 0.5
	else:
		hit_multiplier = 1
	print("should call set score")
	Main.set_score(collateral_hits, hit_multiplier)
	queue_free()
