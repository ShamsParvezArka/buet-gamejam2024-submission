extends StaticBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_chest_open: AudioStreamPlayer2D = $AudioChestOpen
@onready var audio_chest_close: AudioStreamPlayer2D = $AudioChestClose
@onready var prompt: Node2D = $Prompt
@onready var key: Sprite2D = $Prompt/Key
@onready var item_prompt: AnimationPlayer = $AnimationPlayer
@onready var item_label: Label = $ItemLabel

var inside := false
var open := false
var is_sowrd_obtained := false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Protagonist":
		inside = true
		prompt.visible = true


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("key_f") and inside and !open:
		key.frame_coords.y = 1
		audio_chest_open.play()
		animated_sprite_2d.play("chest_open")
		open = true
	elif Input.is_action_just_released("key_f") and inside:
		key.frame_coords.y = 0


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Protagonist" and open:
		open = false
		inside = false
		prompt.visible = false
		audio_chest_close.play()
		animated_sprite_2d.play("chest_close")
		item_label.visible = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "chest_open" and !is_sowrd_obtained:
		item_label.visible = true
		item_prompt.play("sowrd_obtained")
		is_sowrd_obtained = true
