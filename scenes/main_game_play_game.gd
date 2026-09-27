extends Node

@onready var maze: Node2D = $Maze
@onready var puzzles_container: Node = $Puzzles

var current_puzzle_instance: Node = null
var current_trigger_tile: Area2D = null

func switch_to_puzzle(puzzle_path: String, trigger_tile: Area2D) -> void:
	# Store the tile that sent us here so we can disable it later
	current_trigger_tile = trigger_tile
	
	# 1. Freeze and hide the entire Maze branch (deferred so we're not
	# touching collision objects mid-physics-step)
	maze.set_deferred("visible", false)
	maze.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
	
	# 2. Dynamically load and instance the requested puzzle
	var puzzle_resource = load(puzzle_path)
	if puzzle_resource:
		current_puzzle_instance = puzzle_resource.instantiate()
		
		# Injects the puzzle directly into your empty 'Puzzles' node
		puzzles_container.add_child(current_puzzle_instance)
		
		# Connect to your puzzle's completion signal
		current_puzzle_instance.connect("puzzle_completed", _on_puzzle_completed)

func _on_puzzle_completed() -> void:
	# 1. Safely remove and clean up the puzzle room from your 'Puzzles' node
	if current_puzzle_instance:
		current_puzzle_instance.queue_free()
		current_puzzle_instance = null
		
	# 2. Deactivate the Area2D checkpoint permanently so the player can't re-trigger it
	if current_trigger_tile:
		current_trigger_tile.queue_free()
		current_trigger_tile = null

	# 3. Unfreeze and show your Maze exactly how it was left (deferred, same reason as above)
	maze.set_deferred("visible", true)
	maze.set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
