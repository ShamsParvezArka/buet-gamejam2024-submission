extends Area2D

@onready var state_machine: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var prompt: Node2D = $"../Prompt"
@onready var key: Sprite2D = $"../Prompt/Key"

var inside := false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonist":
		inside = true
		prompt.visible = true
		state_machine.play("blink")
		

func _on_body_exited(body: Node2D) -> void:
	prompt.visible = false
	state_machine.play("idle")
	
func _input(event: InputEvent) -> void: 
	if Input.is_action_just_pressed("key_f") and inside:
		key.frame_coords.y = 1
	elif Input.is_action_just_released("key_f") and inside:
		key.frame_coords.y = 0
		
