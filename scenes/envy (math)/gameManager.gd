extends Node

signal speed_increased(new: float)
signal time_up

@export var base = 100.0
@export var inc = 10.0
@export var time = 30.0

var elap = 0.0
var current = 0.0
var running: bool = true
var is_dialog_finished := false

func _ready() -> void:
	current = base

func _process(delta: float) -> void:
	if not running:
		return
		
	elap += delta
	
	if elap >= time:
		end_seq()
		return
		
	var new = base + inc * floor(elap)
	if new != current:
		current = new
		speed_increased.emit(current)
	
func end_seq():
	running = false
	time_up.emit()

func restart():
	elap = 0.0
	running = true
	current = base
