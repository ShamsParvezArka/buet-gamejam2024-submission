extends StaticBody2D

@onready var protagonist: CharacterBody2D = $"../Protagonist"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _process(delta: float) -> void:
	if protagonist.switches:
		collision_shape_2d.disabled = true
		animated_sprite_2d.frame = 0
	else:
		collision_shape_2d.disabled = false
		animated_sprite_2d.frame = 3
