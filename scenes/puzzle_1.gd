extends Area2D

# Export the file path of the specific puzzle room this tile loads
@export_file("*.tscn") var puzzle_room_path: String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# Find the master SceneManager and tell it to load this puzzle
		get_node("/root/GameRoot").switch_to_puzzle(puzzle_room_path)
