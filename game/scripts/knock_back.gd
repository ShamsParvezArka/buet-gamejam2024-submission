extends Area2D

@onready var protagonist: CharacterBody2D = $"../../../Protagonist"
@onready var player_area_2d: Area2D = protagonist.get_node("Area2D")
@onready var mob_bat: CharacterBody2D = $".."


var knock_back_position:Vector2 = Vector2.ZERO
var SPEED = 50
var has_entered = false
var OFFSET = 10


func _on_area_entered(area: Area2D) -> void:
	if area == player_area_2d:
		print("body entered")
		has_entered = true
		
func _on_area_exited(area: Area2D) -> void:
	if area == player_area_2d:
		has_entered = false
		
func _physics_process(delta: float) -> void:
	pass
