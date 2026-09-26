extends CharacterBody2D
@onready var collision_polygon : CollisionPolygon2D = $"../boxBounds/CollisionPolygon2D"
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
	var global_target = global_position + dir * tile_size
	var target = collision_polygon.to_local(global_target)
	var query := PhysicsPointQueryParameters2D.new()
	# uhhh idk also claude was helping me debug this :sob:
	query.collision_mask = (1<<0)|(1<<1)
	query.position = global_target
	query.exclude = [self]
	if not Geometry2D.is_point_in_polygon(target,collision_polygon.polygon):
		print("RETURNED FALSE")
		return false
	if not space_state.intersect_point(query).is_empty():
		return false
	target_pos = global_position + dir * tile_size
	moving = true
	return true
