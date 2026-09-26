extends Area2D

@export var activated :bool
func _ready()->void:
	body_entered.connect(on_body_entered)
func on_body_entered(body:Node2D)->void:
	if activated:
		if body.is_in_group("player"):
			print("ENTERED")
			get_tree().change_scene_to_file("res://scenes/puzzle_rooms/2/room.tscn")
