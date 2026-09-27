extends Control
@onready var start_btn : Button = $Button

func _ready() -> void:
	start_btn.pressed.connect(on_pressed)

func _input(event: InputEvent) -> void:
	if event is InputEventKey :
		start_btn.grab_focus()

func on_pressed()->void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
