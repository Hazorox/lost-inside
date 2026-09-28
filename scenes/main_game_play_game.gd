extends Node

@onready var maze: Node2D = $Maze
@onready var puzzles_container: Node = $Puzzles

var current_puzzle_instance: Node = null
var current_trigger_tile: Area2D = null

func switch_to_puzzle(puzzle_path: String, trigger_tile: Area2D) -> void:
	current_trigger_tile = trigger_tile
	maze.set_deferred("visible", false)
	maze.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
	var puzzle_resource = load(puzzle_path)
	if puzzle_resource:
		current_puzzle_instance = puzzle_resource.instantiate()
		puzzles_container.add_child(current_puzzle_instance)
		current_puzzle_instance.connect("puzzle_completed", _on_puzzle_completed)

func _on_puzzle_completed() -> void:
	if current_puzzle_instance:
		current_puzzle_instance.queue_free()
		current_puzzle_instance = null
	if current_trigger_tile:
		current_trigger_tile.queue_free()
		current_trigger_tile = null
	maze.set_deferred("visible", true)
	maze.set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
