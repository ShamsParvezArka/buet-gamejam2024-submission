extends Node2D


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_up"):
		$Up.frame_coords.y = 1
	elif Input.is_action_just_released("move_up"):
		$Up.frame_coords.y = 0
		
	if Input.is_action_just_pressed("move_down"):
		$Down.frame_coords.y = 1
	elif Input.is_action_just_released("move_down"):
		$Down.frame_coords.y = 0
		
	if Input.is_action_just_pressed("move_left"):
		$Left.frame_coords.y = 1
	elif Input.is_action_just_released("move_left"):
		$Left.frame_coords.y = 0
		
	if Input.is_action_just_pressed("move_right"):
		$Right.frame_coords.y = 1
	elif Input.is_action_just_released("move_right"):
		$Right.frame_coords.y = 0
