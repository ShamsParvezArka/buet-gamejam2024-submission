extends Area2D

@onready var state_machine: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var prompt: Node2D = $"../Prompt"
@onready var key: Sprite2D = $"../Prompt/Key"
@onready var animation_player: AnimationPlayer = $"../ItemPrompt/AnimationPlayer"
@onready var item_label: Label = $"../ItemPrompt/ItemLabel"

var inside := false


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonist":
		inside = true
		prompt.visible = true
		state_machine.play("blink")
		

func _on_body_exited(body: Node2D) -> void:
	prompt.visible = false
	inside = false
	state_machine.play("idle")
	item_label.visible = false
	
func _input(event: InputEvent) -> void: 
	if Input.is_action_just_pressed("key_f") and inside:
		key.frame_coords.y = 1
		item_label.visible = true
		animation_player.play("game_saved")
	elif Input.is_action_just_released("key_f") and inside:
		key.frame_coords.y = 0
		
