extends TextureProgress


func _process(delta):
	if get_tree().get_root().get_node("Main").boss_alive:
		set_global_position(Vector2(get_global_rect().position.x, 25))
		value = get_tree().get_root().get_node("Main").boss_health
	else:
		value = 0
		
func _ready():
	var bar_size= Vector2(0,0)
	bar_size.x = get_viewport().get_visible_rect().size.x # Get Width
	bar_size.y = 15
	
	rect_size = bar_size
