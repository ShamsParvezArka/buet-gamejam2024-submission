extends CanvasModulate

@onready var protagonist: CharacterBody2D = $"../Protagonist"
@onready var point_light_2d_2: PointLight2D = $"../Protagonist/PointLight2D2"


func _process(delta: float) -> void:
	if protagonist.level == 0:
		point_light_2d_2.visible = false
		color = "#ffffff" 
	elif protagonist.level == 1:
		point_light_2d_2.visible = true
