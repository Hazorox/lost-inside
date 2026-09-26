extends CanvasLayer

@onready var buttons : Array[Button] = [$hsplit/continue,$hsplit/restart]
var focused:int = 0
func _ready() -> void:
	visible=false
	buttons[0].pressed.connect(on_continue)
	buttons[1].pressed.connect(on_restart)

func _process(_delta:float)->void:
	if Input.is_key_pressed(KEY_ESCAPE):
		visible=true
	if visible==true and (Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("down") or Input.is_action_just_pressed("up")):
		if focused==0:
			focused=1
			buttons[1].grab_focus()
		else:
			focused=0
			buttons[0].grab_focus()
func on_continue()->void:
	get_tree().paused=false
	visible=false

func on_restart()->void:
	
	# RESTART GLOBAL VARS HERE
	visible=false
	get_tree().paused=false
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
