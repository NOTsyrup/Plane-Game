extends Area2D





func _on_Area2D_body_entered(body):
	body.take_damage(1)
