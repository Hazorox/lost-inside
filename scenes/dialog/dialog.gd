extends CanvasLayer

@onready var cont: Panel = $MarginContainer/Panel
@onready var label: Label = $Label
@onready var start: Label = $MarginContainer/MarginContainer/HBoxContainer/start
@onready var end: Label = $MarginContainer/MarginContainer/HBoxContainer/end
@onready var textbox: RichTextLabel = $MarginContainer/MarginContainer/HBoxContainer/RichTextLabel
@onready var sprite: Sprite2D = $Sprite2D
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
var queue: Array = []
var tween: Tween
var current = STATE.READY


enum STATE{
	READY,
	READING,
	DONE
}

func _ready() -> void:
	hide_box()
	print("ready")
	add_queue("LOFTY, LEARN WEB", "theta", "res://assets/math/theta/theta.png", "res://assets/soundbeeps/soundbeep1.wav")
	add_queue("LOFTY, LEARN WEB 67676767676767667676767676767677676767676776767677676767667767676","x", "res://assets/math/x/x.png", "res://assets/soundbeeps/soundbeep2.wav")
	
func hide_box():
	cont.hide()
	start.text = ""
	label.text = ""
	end.text = ""
	textbox.text = ""
	sprite.hide()
	
func show_box():
	cont.show()
	start.text = "*"
	sprite.show()

func add_queue(text, who, sprite_path: String = "", sound_path: String = ""):
	queue.push_back({
		"text": text,
		"speaker": who,
		"sound": sound_path,
		"sprite": sprite_path
	})
	
func add_text(entry: Dictionary):
	change_state(STATE.READING)
	var text = entry.text
	var l = entry.speaker
	label.text = l
	var sound = entry.sound
	var sp = entry.sprite
	var tex: Texture2D = load(sp)
	sprite.sett_texture(tex)
	show_box()
	textbox.text = text
	tween = create_tween()
	textbox.visible_ratio = 0.0
	var duration: float = 0.05 * text.length()
	tween.tween_property(textbox, "visible_ratio", 1.0, duration)\
		.from(0.0)\
		.set_trans(Tween.TRANS_LINEAR)\
		.set_ease(Tween.EASE_IN)
	tween.finished.connect(_on_tween_finished)
	audio.stream = load(sound)
	play_audio()
	
	
func _on_tween_finished():
	end.text = "v"
	audio.stop()
	change_state(STATE.DONE)
	
func change_state(next):
	current = next
	match current:
		STATE.READY:
			print("ready")
		STATE.READING:
			print("read")
		STATE.DONE:
			print("done")
			
func play_audio():
	while current == STATE.READING:
		if not audio.playing:
			audio.play()
		var t = pow(randf(), 5)
		var random = lerp(0.05, 0.3, t)
		await get_tree().create_timer(random).timeout

func _process(delta: float) -> void:
	match current:
		STATE.READY:
			if !queue.is_empty():
				var entry = queue.pop_front()
				add_text(entry)
		STATE.READING:
			if Input.is_action_just_pressed("ui_accept"):
				textbox.visible_ratio = 1.0
				tween.stop()
				audio.stop()
				end.text = "v"
				change_state(STATE.DONE)
		STATE.DONE:
			if Input.is_action_just_pressed("ui_accept"):
				hide_box()
				change_state(STATE.READY)
