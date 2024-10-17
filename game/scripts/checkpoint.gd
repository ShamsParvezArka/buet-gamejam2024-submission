extends Area2D

@onready var protagonist: CharacterBody2D = $".."

var inside := false

func _on_area_entered(area: Area2D) -> void:
	if area.name == "RefrigeratorArea":
		inside = true


func _on_area_exited(area: Area2D) -> void:
	inside = false
	

func _input(event: InputEvent) -> void:
	if inside and Input.is_action_just_released("key_f"):
		protagonist.last_saved_pos = protagonist.position

		
		
