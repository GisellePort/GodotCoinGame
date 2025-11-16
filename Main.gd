extends Node2D

# Fade screen to black
#screen wouldnt fade to black but seems fixed now
func fade_to_black_and_show():
	var fade = $UI_Layer/FadeOverlay
	fade.visible = true
	fade.modulate.a = 0.0  # start transparent

	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, 1.0) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	await tween.finished

	# After fading show final
	show_final_message()

# Display end game picture
func show_final_message():
	var sprite = Sprite2D.new()
	sprite.texture = load("res://smallchest.png")
	
	# Center the image
	sprite.centered = true
	var size = get_viewport().get_visible_rect().size
	sprite.position = size / 2

	$UI_Layer.add_child(sprite)
