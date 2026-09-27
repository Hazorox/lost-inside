extends CharacterBody2D


const SPEED = 300.0
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
		# Area to scan for boxes to & from
		var from = global_position
		
		# Uhhh idk why 56 I got some help from Claude here
		var to = global_position + last_dir * 56
		# Setting up the ray detection and excluding the node itself from the detection
		var space_state = get_world_2d().direct_space_state
		var query := PhysicsRayQueryParameters2D.create(from, to)
		
		# restrict to objects only so bounds dont affect
		query.collision_mask = (1<<2)
		query.exclude = [self]
		
		# Attempting to push if its a box
		var result := space_state.intersect_ray(query)
		if not result.is_empty():
			if result.collider.is_in_group("box"):
				result.collider.attempt_push(last_dir)
	move_and_slide()
