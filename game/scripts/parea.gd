extends Area2D

@onready var protagonist: CharacterBody2D = $".."


func _on_area_entered(area: Area2D) -> void:
	if area.name == "SpikeZone":
		protagonist.is_dead = true
		protagonist.can_move = false
		
