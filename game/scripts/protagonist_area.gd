extends Area2D

@onready var protagonist: CharacterBody2D = $".."

func _on_area_entered(area: Area2D) -> void:
	if area.name == "RefrigeratorArea":
		protagonist.can_save = true
	elif area.name == "ChestArea":
		protagonist.is_chest = true
		

func _on_area_exited(area: Area2D) -> void:
	protagonist.can_save = false
	protagonist.is_chest = false
	protagonist.can_open = false
