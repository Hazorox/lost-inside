extends StaticBody2D

# Managing both door and chest here

@onready var door:Area2D = $"../door"
@onready var tilemap:TileMapLayer = $chest
var door_ready :=false
var interactable := false

func _ready()->void:
	door.body_entered.connect(on_body_entered)
	door.body_exited.connect(on_body_exited)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and interactable and door_ready:
		get_parent().finished.emit()
func boom()->void:
	# DIALOG U WERE GIVEN THE KEY
	tilemap.visible=false
	door_ready = true


func on_body_entered(body:Node2D)->void:
	if body.is_in_group("player"):
		print("PLAYER GONNA INTERACT")
		interactable = true
func on_body_exited(body:Node2D)->void:
	if body.is_in_group("player"):
		interactable=false
