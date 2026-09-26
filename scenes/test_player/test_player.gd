extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var last_dir :Vector2 = Vector2.DOWN

func _physics_process(delta: float) -> void:
	var direction_y := Input.get_axis("up","down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y,0,SPEED)
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_y <0:
		last_dir = Vector2.UP
	elif direction_y >0:
		last_dir = Vector2.DOWN
	if direction <0:
		last_dir = Vector2.LEFT
	elif direction>0:
		last_dir = Vector2.RIGHT
	
	if Input.is_action_just_pressed("interact"):
		var from = global_position
		var to = global_position + last_dir * 48
		print("from: ", from, " to: ", to)
		var space_state = get_world_2d().direct_space_state
		var query := PhysicsRayQueryParameters2D.create(from, to)
		query.exclude = [self]
		var result := space_state.intersect_ray(query)
		print("result: ", result)

	move_and_slide()
