extends StaticBody2D

@onready var protagonist: CharacterBody2D = $"../Protagonist"
@onready var spike_zone: CollisionShape2D = $SpikeZone
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _process(delta: float) -> void:
	if protagonist.switches:
		spike_zone.disabled = true
		animated_sprite_2d.frame = 0
	else:
		spike_zone.disabled = false
		animated_sprite_2d.frame = 3
