extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var prompt: Node2D = $"../Prompt"
@onready var key: Sprite2D = $"../Prompt/Key"
@onready var lever: StaticBody2D = $".."
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

var inside := false


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonist":
		inside = true
		prompt.visible = true


func _on_body_exited(body: Node2D) -> void:
	prompt.visible = false
	inside = false
	
func _input(event: InputEvent) -> void: 
	if Input.is_action_just_pressed("key_c") and inside:
		key.frame_coords.y = 1
		if !lever.on:
			animated_sprite_2d.play("pull")
			if !audio_stream_player_2d.playing:
				audio_stream_player_2d.play()
		else:
			animated_sprite_2d.play("pull_backward")
			if !audio_stream_player_2d.playing:
				audio_stream_player_2d.play()
		lever.on = !lever.on
	elif Input.is_action_just_released("key_c") and inside:
		key.frame_coords.y = 0
