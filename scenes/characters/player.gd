class_name Player
extends CharacterBody2D

@onready var player_sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $"."

@export var speed := 100

enum State{
	IDLE,
	WALKING,
	ATTACKING,
}

var heading = Vector2.RIGHT
var state := State.IDLE

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction * speed
	move_and_slide()
	set_heading()
	flip_sprites()
	if velocity != Vector2.ZERO:
		is_player_walking()
	var is_attacking = animation_player.is_playing() and animation_player.current_animation.ends_with("attack")
	if is_player_attacking() and not is_attacking:
		set_hitting_animation()
	elif not is_attacking:
		if is_player_walking():
			set_walking_animation()
		else:
			set_idle_animation()

func is_player_walking() -> bool:
	if player.velocity != Vector2.ZERO:
		return true
	else:
		return false

func is_player_attacking() -> bool:
	if Input.is_action_just_pressed("attack"):
		return true
	else:
		return false

func set_heading() -> void:
	if velocity.x > 0:
		heading = Vector2.RIGHT
	elif velocity.x < 0:
		heading = Vector2.LEFT
	elif velocity.y > 0:
		heading = Vector2.DOWN
	elif velocity.y < 0:
		heading = Vector2.UP

func set_idle_animation() -> void:
	if velocity.length() == 0 and heading == Vector2.UP:
		animation_player.play("back_idle")
	elif velocity.length() == 0 and heading == Vector2.DOWN:
		animation_player.play("front_idle")
	elif velocity.length() == 0 and heading == Vector2.LEFT:
		animation_player.play("side_idle")
	elif velocity.length() == 0 and heading == Vector2.RIGHT:
		animation_player.play("side_idle")

func set_walking_animation() -> void:
	if velocity.length() > 0 and heading == Vector2.UP:
		animation_player.play("back_walk")
	elif velocity.length() > 0 and heading == Vector2.DOWN:
		animation_player.play("front_walk")
	elif velocity.length() > 0 and heading == Vector2.LEFT:
		animation_player.play("side_walk")
	elif velocity.length() > 0 and heading == Vector2.RIGHT:
		animation_player.play("side_walk")

func set_hitting_animation() -> void:
	if Input.is_action_just_pressed("attack") and heading == Vector2.UP:
		animation_player.play("back_attack")
	elif Input.is_action_just_pressed("attack") and heading == Vector2.DOWN:
		animation_player.play("front_attack")
	elif Input.is_action_just_pressed("attack") and heading == Vector2.RIGHT:
		animation_player.play("side_attack")
	elif Input.is_action_just_pressed("attack") and heading == Vector2.LEFT:
		animation_player.play("side_attack")

func flip_sprites() -> void:
	if heading == Vector2.RIGHT:
		player_sprite.flip_h = false
	elif heading == Vector2.LEFT:
		player_sprite.flip_h = true
