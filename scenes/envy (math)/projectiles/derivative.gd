extends Area2D

@export var speed = 0.0
var direction = Vector2.LEFT
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.time_up.connect(time_up)
	$VisibleOnScreenNotifier2D.screen_exited.connect(on_screen_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not GameManager.running:
		return
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit()
	queue_free()
	
func time_up():
	set_physics_process(false)
	
func on_screen_exited():
	queue_free()
