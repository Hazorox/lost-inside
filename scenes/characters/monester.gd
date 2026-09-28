extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var damage_emitter_shape: CollisionShape2D = $DamageEmitter/CollisionShape2D

const SPEED := 50.0
const ATTACK_RANGE := 75.0
const DURATION_BETWEEN_ATTACKS := 500

var heading := Vector2.RIGHT
var player: Player = null
var is_attacking := false
var is_detected  := false

func _ready() -> void:
	damage_emitter_shape.disabled = true
	player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	if player == null:
		return
	set_heading()
	flip_sprite()
	set_animation()
	var distance := global_position.distance_to(player.global_position)
	if distance >= 20:
		if is_detected == true and not is_attacking:
			var direction := ((player.global_position - global_position)).normalized()
			velocity = direction * SPEED
			move_and_slide()
		if is_attacking:
			damage_emitter_shape.disabled = false
		else:
			damage_emitter_shape.disabled = true

func set_heading() -> void:
	if velocity.x > 0:
		heading = Vector2.RIGHT
	elif velocity.x < 0:
		heading = Vector2.LEFT

func flip_sprite() -> void:
	if heading == Vector2.LEFT:
		sprite_2d.scale.x = -1
		damage_emitter_shape.position.x = -17.5
	elif heading == Vector2.RIGHT:
		sprite_2d.scale.x = 1
		damage_emitter_shape.position.x = 17.5

func set_animation() -> void:
	if is_attacking:
		return
	if velocity != Vector2.ZERO:
		animation_player.play("walking")
	else:
		animation_player.play("idle")

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name == "attacking_1":
		is_attacking = false
	if anim_name == "attacking_2":
		is_attacking = false

func _on_attack_range_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		is_detected = true
	if is_attacking or player == null:
		return
	if global_position.distance_to(player.global_position) < ATTACK_RANGE:
		is_attacking = true
		velocity = Vector2.ZERO
		animation_player.play("attacking_" + str(randi_range(1,2)))


func _on_damage_reciever_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_damage_emitter"):
		queue_free()
