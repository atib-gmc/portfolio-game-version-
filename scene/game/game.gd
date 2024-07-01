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
