extends Area2D

@export_file("*.tscn") var puzzle_room_path: String

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		visible = false
		set_deferred("monitoring", false)
		get_node("/root/MainGamePlayGame").call_deferred("switch_to_puzzle", puzzle_room_path, self)
