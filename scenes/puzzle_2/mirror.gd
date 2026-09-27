extends Node2D

@export var direction := Vector2.RIGHT

@onready var sprite := $sprite
@onready var reflector = $reflector
@onready var interaction_area = $interaction_area

var interactable := false

func _ready()->void:
	sprite.flip_h = direction == Vector2.LEFT
	interaction_area.body_entered.connect(on_body_entered)
	interaction_area.body_exited.connect(on_body_exited)


func _process(_detla:float)->void:
	if Input.is_action_just_pressed("interact") and interactable:
		if direction==Vector2.RIGHT:
			direction = Vector2.LEFT
			sprite.flip_h=false
		elif direction == Vector2.LEFT:
			direction = Vector2.RIGHT
			sprite.flip_h=true


func on_body_entered(body:Node2D)->void:
	if body.is_in_group("player"):
		interactable = true

func on_body_exited(body:Node2D)->void:
	if body.is_in_group("player"):
		interactable = false
