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
@onready var player_area_2d: Area2D = player.get_node("Area2D")


var knock_back_position:Vector2 = Vector2.ZERO
var SPEED_KNOCK = 50
var has_entered = false

func _ready() -> void:
	mob_animated_sprite_2d.play("fly_right")
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area == player_area_2d):
		SPEED *= 1
		mob_animated_sprite_2d.play("attack_right")



func _on_area_2d_area_exited(body: Node2D) -> void:
	SPEED = 10.0
	mob_animated_sprite_2d.play("fly_right")
	


func _physics_process(delta: float) -> void:
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
	if player_position.x < position.x:
		mob_animated_sprite_2d.flip_h = true
	else:
		mob_animated_sprite_2d.flip_h = false
	rotation_degrees = wrap(rotation_degrees , 0 , 360)
	
	if(Input.is_action_pressed("mouse_left") and has_entered and player.weapon_equipped ):
		knock_back_position = knock_back_position.move_toward(Vector2.ZERO , 200 * delta)
		if (position != knock_back_position):
			if(position.x < player.position.x):
				position -= Vector2(SPEED_KNOCK,SPEED_KNOCK) * delta
			elif (position.x > player.position.x):
				position += Vector2.RIGHT*SPEED_KNOCK * delta
	
	move_and_slide()
	
		

	
