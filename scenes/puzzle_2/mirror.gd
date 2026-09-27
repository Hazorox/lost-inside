extends Node2D

@export var dir := Vector2.RIGHT

@onready var sprite := $sprite
@onready var reflector = $reflector
@onready var interaction_area = $interaction_area

var interactable := false
var directions := [Vector2.LEFT,Vector2.UP,Vector2.RIGHT,Vector2.DOWN]
func _ready()->void:
	update_sprite()
	interaction_area.body_entered.connect(on_body_entered)
	interaction_area.body_exited.connect(on_body_exited)


func _process(_detla:float)->void:
	if Input.is_action_just_pressed("interact") and interactable:
		print("INTERACTED")
		var index := directions.find(dir)
		# Got help from claude for this index logic
		dir = directions[(index+1) %directions.size()]
		update_sprite()

func update_sprite()->void:
	sprite.flip_h = dir==Vector2.LEFT

func on_body_entered(body:Node2D)->void:
	print("BODY ENTERED")
	if body.is_in_group("player"):
		print("NOW INTERACTABLE")
		interactable = true

func on_body_exited(body:Node2D)->void:
	if body.is_in_group("player"):
		interactable = false
