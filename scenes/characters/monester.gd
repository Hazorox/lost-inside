extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED := 50

var heading := Vector2.RIGHT
var player : Player = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	set_heading()
	flip_sprite()
	set_animation()
	if player.global_position - global_position < Vector2(100, 100):
		var direction := ((player.global_position - global_position)).normalized()
		velocity = direction * SPEED
		move_and_slide()

func set_heading() -> void:
	if velocity.x > 0:
		heading = Vector2.RIGHT
	elif velocity.x < 0:
		heading = Vector2.LEFT

func flip_sprite() -> void:
	if heading == Vector2.RIGHT:
		sprite_2d.flip_h = false
	elif heading == Vector2.LEFT:
		sprite_2d.flip_h = true

func set_animation() -> void:
	if player.velocity != Vector2.ZERO:
		animation_player.play("walking")
	else:
		animation_player.play("idle")
