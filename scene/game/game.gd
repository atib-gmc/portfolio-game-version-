extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_button_pressed():
	$CanvasLayer/AspectRatioContainer.visible = !$CanvasLayer/AspectRatioContainer.visible

func _on_restart_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.

func _on_quit_btn_pressed():
	get_tree().quit()
	pass # Replace with function body.

func _on_travel_body_entered(body: Node2D):
	print("player enter")
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scene/game/world_2.tscn")
	pass # Replace with function body.
