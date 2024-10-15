extends Area2D

@onready var primary_cam = $"../../Protagonist/Camera2D"
@onready var secondary_cam = $"../Path2D/PathFollow2D/Camera2D"
@onready var animation = $"../AnimationPlayer"
@onready var protagonist = $"../../Protagonist"

var has_played := false
	

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonist" and has_played == false:
		protagonist.can_move = false
		has_played = true
		animation.play("show_cut_scene")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	protagonist.can_move = true
	
