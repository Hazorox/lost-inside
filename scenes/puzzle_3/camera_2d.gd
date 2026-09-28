extends Camera2D

@onready var target: Player = $".."

func _process(_delta: float) -> void:
	if target:
		global_position = target.global_position
