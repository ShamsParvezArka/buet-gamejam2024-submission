extends Area2D

@onready var protagonist: CharacterBody2D = $".."

func _on_area_entered(area: Area2D) -> void:
	if area.name == "RefrigeratorArea" and Input.is_action_just_released("key_f"):
		protagonist.last_saved_pos = protagonist.position
		
		
