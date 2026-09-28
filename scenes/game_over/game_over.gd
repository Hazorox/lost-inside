extends Control

@onready var btn: Button = $CanvasLayer/Button

func _ready() -> void:
	btn.pressed.connect(on_pressed)

func on_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
