extends StaticBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Protagonist" and body.can_open == true:
			animated_sprite_2d.play("chest_open")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Protagonist" and body.can_open:
		animated_sprite_2d.play("chest_close")
