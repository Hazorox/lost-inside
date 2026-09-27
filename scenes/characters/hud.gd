extends Control

@onready var life_sprites: Array[Sprite2D] = [
	$Life, $Life2, $Life3, $Life4, $Life5,
	$Life6, $Life7, $Life8, $Life9, $Life10
]

var previous_lives := 10

func _ready() -> void:
	update_lives()

func _process(_delta: float) -> void:
	if Globals.player_lives != previous_lives:
		previous_lives = Globals.player_lives
		update_lives()

func update_lives() -> void:
	for i in life_sprites.size():
		if i >= Globals.player_lives and is_instance_valid(life_sprites[i]):
			life_sprites[i].queue_free()

	if Globals.player_lives <= 0:
		get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
