extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("key_f"):
		sprite_2d.frame_coords.y = 1
	elif Input.is_action_just_released("key_f"):
		sprite_2d.frame_coords.y = 0
