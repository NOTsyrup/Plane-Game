extends Node2D

onready var small_explosion_right = $SmallExplosionParticles1
onready var small_explosion_left = $SmallExplosionParticles2
onready var smoke_particles = $SmokeParticles
onready var big_explostion = $BigExplosionParticles

var little_timer_out = false
var big_timer_out = false
var should_timer_little = true
var should_timer_big = true

var end_explosion = false

var can_explode = false

func _process(delta):
	if can_explode:
		exploding()
	
func exploding():
	if not end_explosion:
		smoke_particles.emitting = true
		small_explosion_right.emitting = true
		if should_timer_little:
			$LittleExplosionTimer.start()
			should_timer_little = false
		if little_timer_out:
			small_explosion_left.emitting = true
		if should_timer_big:
			$BigExplosion.start()
			should_timer_big = false
		if big_timer_out:
			big_explostion.emitting = true
			end_explosion = true
	else:
		small_explosion_left.emitting = false
		small_explosion_right.emitting = false
		smoke_particles.emitting = false
		
		


func _on_LittleExplosionTimer_timeout():
	little_timer_out = true
	

func _on_BigExplosion_timeout():
	big_timer_out = true
	get_parent().find_node("AnimatedSprite").visible = false
