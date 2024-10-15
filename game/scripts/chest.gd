extends StaticBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_inside := false
var is_open := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Protagonist":
		is_inside = true


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("key_f") and is_inside:
		animated_sprite_2d.play("chest_open")
		is_open = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Protagonist" and is_open:
		is_open = false
		is_inside = false
		animated_sprite_2d.play("chest_close")
