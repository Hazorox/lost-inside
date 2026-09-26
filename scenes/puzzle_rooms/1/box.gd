extends CharacterBody2D

@export var speed = 20
var tile_size = 16
var on_plate :=false
var moving :=false
var move_dir = Vector2.ZERO
var target_pos = Vector2.ZERO
func _ready() -> void:
	target_pos = global_position

func _physics_process(delta: float) -> void:
	if moving:
		global_position = global_position.move_toward(target_pos, speed * tile_size * delta)
		if global_position.distance_to(target_pos) < 1.0:
			global_position = target_pos
			moving = false

func attempt_push(dir:Vector2)->bool:
	if moving:
		return false
	var space_state = get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = global_position+dir*tile_size
	target_pos = global_position + dir * tile_size
	move_dir = dir
	moving = true
	return true
