extends Area2D

@export var sprite_node: NodePath  # Path to the UI sprite 
@export var bob_amount := 5.0      # move coin up and down
@export var bob_speed := 2.0       # speed 

var collected := false
var start_y := 0.0
var time_passed := 0.0
var local_sprite: Sprite2D  #null causes error

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	
	# reference to the world sprite
	local_sprite = get_node("SpriteC")
	if local_sprite:
		start_y = local_sprite.position.y

func _process(delta):
	if not collected and local_sprite:
		time_passed += delta * bob_speed
		local_sprite.position.y = start_y + sin(time_passed) * bob_amount

func _on_body_entered(body):
	if body.name == "Player" and not collected:
		collected = true

		#  collect sound
		var sfx = get_tree().get_current_scene().get_node("SFXPlayer")
		if sfx:
			sfx.play()

		# Hide sprite
		if local_sprite:
			local_sprite.visible = false

		#  Show the UI sprite
		var ui_layer = get_tree().get_current_scene().get_node("UI_Layer")
		if ui_layer:
			var sprite = ui_layer.get_node(sprite_node)
			if sprite:
				sprite.visible = true

		# Update the global collectible counter
		GameState.collected_cs += 1

		# collecting final Coin scene
		if GameState.collected_cs == GameState.TOTAL_CS:
			await get_tree().get_current_scene().fade_to_black_and_show()

		# be free collectible
		queue_free()
