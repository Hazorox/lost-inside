extends Area2D

@onready var treasure: Area2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var time_since_opened := Time.get_ticks_msec()

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	if time_since_opened > 3500:
			treasure.queue_free()

func _on_area_entered(area: Area2D) -> void:
	time_since_opened = Time.get_ticks_msec()
	if area.is_in_group("player"):
		animated_sprite_2d.play("open")
		Globals.owned_keys +=1
