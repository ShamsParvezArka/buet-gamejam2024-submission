extends Area2D

@onready var state_machine: AnimatedSprite2D = $"../AnimatedSprite2D"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonist":
		state_machine.play("blink")
		

func _on_body_exited(body: Node2D) -> void:
	state_machine.play("idle")
	
