extends Node2D

@export var direction = Vector2.UP
@onready var line := $Line2D
@export var length := 800.0
@export var collision_mask = 0xFFFFFF
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	cast()


func cast()->void:
	var space := get_world_2d().direct_space_state
	var points :Array[Vector2] = [global_position]
	var current_pos := global_position
	var current_dir = direction.normalized()
	# 
	for i in range(7):
		var query = PhysicsRayQueryParameters2D.create(
			current_pos,current_pos+direction*length
		)
		query.collide_with_areas=true
		query.collision_mask = collision_mask
		
		var result = space.intersect_ray(query)
		print(result)
		if result.is_empty():
			points.append(current_pos+direction*length)
			break
		points.append(result.position)
		var colliding_object = result.collider
		print(result)
		if colliding_object.is_in_group("mirror"):
			print("COLLIDED")
			var mirror = colliding_object.get_parent()
			direction = mirror.dir.normalized()
			current_pos = result.position +direction * 2.0
		elif colliding_object.is_in_group("chest"):
			var parent = colliding_object.get_parent()
			parent.boom()
			points.append(result.position)
			break
		else:
			break
			
	var local_points : Array[Vector2] = []
	for p in points:
		local_points.append(to_local(p))
	line.points = local_points
