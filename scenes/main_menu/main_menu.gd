extends Control
@onready var start_btn : Button = $Button
@onready var start_btn2 : Button = $Button2

func _ready() -> void:
	start_btn.pressed.connect(on_pressed)
	start_btn2.pressed.connect(on_pressed2)

func on_pressed()->void:
	get_tree().change_scene_to_file("res://scenes/temp/maze.tscn")

func on_pressed2()->void:
	get_tree().change_scene_to_file("res://scenes/envy (math)/envy.tscn")
