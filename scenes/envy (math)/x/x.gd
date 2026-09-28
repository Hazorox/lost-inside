extends CharacterBody2D

const SPEED = 300.0

func _ready() -> void:
	GameManager.time_up.connect(time_up)

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	direction = direction.normalized()
	velocity = SPEED * direction

	move_and_slide()
	
func hit():
	set_physics_process(false)
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	if not is_inside_tree():
		return
	get_tree().change_scene_to_file("res://scenes/game_over/gameOver.tscn")
	
func time_up():
	set_physics_process(false)
	velocity = Vector2.ZERO
