extends Node2D
signal finished
var plates_pressed = 0
@onready var door : Area2D = $door
@onready var plates : Array[Area2D] = [$plate,$plate2,$plate3]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for plate in plates:
		plate.pressed.connect(plate_pressed)
		plate.unpressed.connect(plate_unpressed)

func _process(_delta: float) -> void:
	door.visible= plates_pressed==3

func plate_pressed()->void:
	plates_pressed+=1
func plate_unpressed()->void:
	plates_pressed-=1
