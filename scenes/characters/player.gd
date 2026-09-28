class_name Player
extends CharacterBody2D

const SPEED = 300.0

# Local position of the attack hitbox for each facing direction.
# LEFT uses the same value as RIGHT because the whole DamageEmitter is mirrored.
const ATTACK_OFFSETS := {
	Vector2.UP: Vector2(-1, -17),
	Vector2.RIGHT: Vector2(12, -5),
	Vector2.LEFT: Vector2(12, -5),
	Vector2.DOWN: Vector2(0, 2),
}

@onready var player_sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var damage_emitter: Area2D = $DamageEmitter
@onready var collision_shape_2d: CollisionShape2D = $DamageEmitter/CollisionShape2D

enum State {
	IDLE,
	WALKING,
	ATTACKING,
}

@export var heading: Vector2 = Vector2.DOWN
var state := State.IDLE


func _physics_process(delta: float) -> void:
	var direction_y := Input.get_axis("up", "down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	var direction_x := Input.get_axis("left", "right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction_y < 0:
		heading = Vector2.UP
	elif direction_y > 0:
		heading = Vector2.DOWN
	if direction_x < 0:
		heading = Vector2.LEFT
	elif direction_x > 0:
		heading = Vector2.RIGHT

	if Input.is_action_just_pressed("interact"):
		try_push_box()

	move_and_slide()

	flip_sprites()
	update_animation()


func try_push_box() -> void:
	# Area to scan for boxes to push
	var from = global_position
	# Uhhh idk why 56, got some help from Claude here
	var to = global_position + heading * 56

	var space_state = get_world_2d().direct_space_state
	var query := PhysicsRayQueryParameters2D.create(from, to)

	# restrict to objects only so bounds don't affect
	query.collision_mask = (1 << 2)
	query.exclude = [self]

	var result := space_state.intersect_ray(query)
	if not result.is_empty():
		if result.collider.is_in_group("box"):
			result.collider.attempt_push(heading)


func is_player_walking() -> bool:
	return velocity != Vector2.ZERO


func is_player_attacking() -> bool:
	return Input.is_action_just_pressed("attack")


func update_animation() -> void:
	var is_attacking = animation_player.is_playing() and animation_player.current_animation.ends_with("attack")
	if is_attacking:
		return
	if is_player_attacking():
		start_attack()
	elif is_player_walking():
		set_walking_animation()
	else:
		set_idle_animation()


func start_attack() -> void:
	# Move the hitbox to the side the player is facing, then enable it
	collision_shape_2d.position = ATTACK_OFFSETS[heading]
	collision_shape_2d.set_deferred("disabled", false)
	set_hitting_animation()


func set_idle_animation() -> void:
	match heading:
		Vector2.UP:
			animation_player.play("back_idle")
		Vector2.DOWN:
			animation_player.play("front_idle")
		Vector2.LEFT, Vector2.RIGHT:
			animation_player.play("side_idle")


func set_walking_animation() -> void:
	match heading:
		Vector2.UP:
			animation_player.play("back_walk")
		Vector2.DOWN:
			animation_player.play("front_walk")
		Vector2.LEFT, Vector2.RIGHT:
			animation_player.play("side_walk")


func set_hitting_animation() -> void:
	match heading:
		Vector2.UP:
			animation_player.play("back_attack")
		Vector2.DOWN:
			animation_player.play("front_attack")
		Vector2.LEFT, Vector2.RIGHT:
			animation_player.play("side_attack")


func flip_sprites() -> void:
	if heading == Vector2.RIGHT:
		player_sprite.flip_h = false
		damage_emitter.scale.x = 1
	elif heading == Vector2.LEFT:
		player_sprite.flip_h = true
		damage_emitter.scale.x = -1


func _on_damage_reciever_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage_emitter"):
		Globals.player_lives -= 1


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name.ends_with("attack"):
		collision_shape_2d.set_deferred("disabled", true)
