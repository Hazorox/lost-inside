extends Area2D

func _ready()->void:
	body_entered.connect(on_body_entered)
func on_body_entered(body:Node2D)->void:
	if visible:
		if body.is_in_group("player"):
			Globals.puzzle1=true
			get_tree().change_scene_to_file("res://scenes/puzzle_2/room.tscn")
