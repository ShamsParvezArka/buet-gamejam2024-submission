extends Control

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_start_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/story.tscn")


func _on_quit_button_up() -> void:
	get_tree().quit()


func _on_start_mouse_entered() -> void:
	audio_stream_player_2d.play()


func _on_quit_mouse_entered() -> void:
	audio_stream_player_2d.play()
