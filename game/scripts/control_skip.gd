extends Control

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_texture_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_texture_button_mouse_entered() -> void:
	audio_stream_player_2d.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
