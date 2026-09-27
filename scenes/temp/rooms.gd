extends Node2D

@onready var door_1: CollisionShape2D = $Room_1/Door1
@onready var door_2: CollisionShape2D = $Room_2/Door2
@onready var door_3: CollisionShape2D = $Room_3/Door3
@onready var door_4: CollisionShape2D = $Room_4/Door4
@onready var door_5: CollisionShape2D = $Room_4/Door5
@onready var enemies_1: Node2D = $Room_1/Enemies
@onready var enemies_2: Node2D = $Room_2/Enemies
@onready var enemies_4: Node2D = $Room_4/Enemies

func _process(_delta: float) -> void:
	if enemies_1.get_child_count() == 0:
		door_1.queue_free()
	elif enemies_2.get_child_count() == 0:
		door_2.queue_free()
	elif enemies_4.get_child_count() == 0:
		door_4.queue_free()
		door_5.queue_free()

func _on_enterance_detection_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		door_1.set_deferred("disabled", false)

func _on_enterance_detection_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		door_2.set_deferred("disabled", false)

func _on_enterance_detection_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		door_3.set_deferred("disabled", false)

func _on_enterance_detection_4_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		door_4.set_deferred("disabled", false)

func _on_enterance_detection_5_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		door_5.set_deferred("disabled", false)
