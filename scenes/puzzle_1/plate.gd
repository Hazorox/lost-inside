extends Area2D

signal pressed
signal unpressed
func _ready() -> void:
	body_entered.connect(on_area_entered)
	body_exited.connect(on_area_exited)

func on_area_entered(body:Node2D):
	if body.is_in_group("box"):
		print("PRESSED")
		pressed.emit()

func on_area_exited(body:Node2D):
	if body.is_in_group("box"):
		print("UNPRESSED")
		unpressed.emit()
