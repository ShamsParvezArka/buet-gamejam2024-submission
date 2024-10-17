extends Area2D

@onready var protagonist = $"../Protagonist"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonist":
		protagonist.can_move = false
		protagonist.teleport = true
		protagonist.level += 1
