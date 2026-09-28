extends Node2D


func _on_exit_gate_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if Globals.owned_keys >= 7:
			Dialog.add_queue("You Have gained inner peace", "Inner u", "res://assets/math/x/x.png", "res://assetas/soundbeeps/soundbeep2.wav")
			Dialog.add_queue("You Have finally reached your tresure...", "Inner u", "res://assets/math/x/x.png", "res://assetas/soundbeeps/soundbeep2.wav")
			Dialog.add_queue("Not ur soul...", "Inner u", "res://assets/math/x/x.png", "res://assetas/soundbeeps/soundbeep2.wav")
			Dialog.add_queue("Not ur body", "Inner u", "res://assets/math/x/x.png", "res://assetas/soundbeeps/soundbeep2.wav")
			Dialog.add_queue("but the journey tha purified ur soul.", "Inner u", "res://assets/math/x/x.png", "res://assetas/soundbeeps/soundbeep2.wav")
