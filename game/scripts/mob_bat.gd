extends CharacterBody2D


var SPEED = 20.0
@export var chase_radius = 100
var distance_offset_with_mob = 17

var player_position
var mob_position 
var is_retreating = false 
var retreat_distance = 10
@onready var player: CharacterBody2D = $"../../Protagonist"
@onready var mob_animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	mob_animated_sprite_2d.play("fly_right")
	



func _on_area_2d_area_entered(area: Area2D) -> void:
	SPEED *= 1
	mob_animated_sprite_2d.play("attack_right")
	print("_on_area_2d_area_entered(")
	


func _on_area_2d_area_exited(area: Area2D) -> void:
	SPEED = 10.0
	mob_animated_sprite_2d.play("fly_right")
	


func _physics_process(delta: float) -> void:
	# Add the gravity.
	player_position = player.position
	mob_position = (player_position - position).normalized()
		
	if position.distance_to(player_position) <= chase_radius:
		
		if position.distance_to(player_position) <= distance_offset_with_mob:
			SPEED = 0
		else:
			SPEED = 10.0
		position += mob_position * SPEED * delta
	else:
		SPEED = 0
		#print('player out of range')
		#mob_animated_sprite_2d.play("fly_right")
	if player_position.x < position.x:
		mob_animated_sprite_2d.flip_h = true
		#print("true")
	else:
		mob_animated_sprite_2d.flip_h = false
		#print("false")
	rotation_degrees = wrap(rotation_degrees , 0 , 360)
	
	"""old rotation verison"""
	#look_at(player_position)
	#if rotation_degrees < 90 and rotation_degrees < 270 : 
		##scale.y = -1
	#else :
		##scale.y = 1	
		

	
