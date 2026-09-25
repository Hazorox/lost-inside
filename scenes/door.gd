extends Area2D

@onready var interact: Label = $Label
@export var scene: String
@export var spawn: String = "A"
var in_range: bool = false

func _ready() -> void:
	monitoring = true
	interact.hide()

func _process(delta: float) -> void:
	if in_range and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file(scene)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		in_range = true
		interact.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		in_range = true
