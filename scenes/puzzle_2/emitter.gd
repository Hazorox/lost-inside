extends Node2D

@export var direction = Vector2.UP
@onready var line := $Line2D
@export var length := 800.0
@export var collision_mask = 0xFFFFFF
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("GLOBAL POSITION ",global_position)

func _physics_process(delta: float) -> void:
	cast()


func cast()->void:
	# Initialize variables before mapping the entire laser beam
	var space = get_world_2d().direct_space_state
	var points : Array[Vector2] = [global_position]
	var current_pos = global_position
	var current_dir = direction.normalized()
	
	for i in range(8):
		var query = PhysicsRayQueryParameters2D.create(
			current_pos,current_pos+current_dir*length
		)
		var result = space.intersect_ray(query)
		
		if result.is_empty():
			print("EMPTY RESULT CANCEL CANCEL")
			break
		
		points.append(result.position)
		if result.collider.is_in_group("mirror"):
			current_dir = result.collider.get_parent().dir.normalized()
			current_pos = result.position + current_dir * 2.0
		elif result.collider.is_in_group("chest"):
			result.collider.boom()
		else:
			break
			
			
	var local_points : Array[Vector2] = []
	for p in points:
		local_points.append(to_local(p))
	line.points = local_points
