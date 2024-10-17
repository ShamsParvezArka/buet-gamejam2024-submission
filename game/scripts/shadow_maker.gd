extends Area2D

@onready var canvas_modulate: CanvasModulate = $CanvasModulate

var inside := false


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonist":
		inside = true
		

func _process(delta: float) -> void:
	if inside:
		canvas_modulate.color = "#535353"
