extends Node2D


func _on_exit_gate_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if Globals.owned_keys == 7:
			print("You Have gained inner peace")
