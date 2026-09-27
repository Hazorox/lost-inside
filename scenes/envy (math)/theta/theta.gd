extends CharacterBody2D

const DER = preload("res://scenes/envy (math)/projectiles/derivative.tscn")
const INT = preload("res://scenes/envy (math)/projectiles/integral.tscn")

@export var path: NodePath
@onready var x: Node2D = get_node(path)

var base = 1.5
var rate = 0.0
var timer = 0.1

func _ready() -> void:
	rate = base
	GameManager.speed_increased.connect(inc_speed)
	GameManager.time_up.connect(time_up)

func _physics_process(delta: float) -> void:
	if not GameManager.running:
		return
	timer -= delta
	if timer <= 0:
		shoot()
		timer = rate

func shoot():
	if not is_instance_valid(x):
		push_warning("theta: 'x' reference is not set!")
		return
		
	if GameManager.is_dialog_finished:
		var wpn
		if randi()%2 == 0:
			wpn = INT
		else:
			wpn = DER
		var proj = wpn.instantiate()
		get_tree().current_scene.add_child(proj)
		proj.global_position = global_position
		proj.direction = (x.global_position - global_position).normalized()
		proj.speed = GameManager.current
		
func inc_speed(new: float):
	rate = max(0.2, base - (new - GameManager.base)*0.01)

func time_up():
	set_physics_process(false)
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	get_tree().change_scene_to_file("res://scenes/hall/hall.tscn")
