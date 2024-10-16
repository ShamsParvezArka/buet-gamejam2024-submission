extends CharacterBody2D


var SPEED = 20.0
@export var chase_radius = 100
var distance_offset_with_mob = 17
@onready var player: CharacterBody2D = $"../../Protagonist"

@onready var mob_animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_area_2d: Area2D = player.get_node("Area2D")



var player_position
var mob_position 
var is_retreating = false 
var retreat_distance = 10

#knock_back variables
var knockback_force = 200  # Adjust the knockback force as needed
var is_knocked_back = false
var knockback_velocity: Vector2
var has_entered = false
#var knock_back_dir:Vector2 = Vector2.ZERO
var knock_back_power:int = 200


func _ready() -> void:
	mob_animated_sprite_2d.play("fly_right")
	
func apply_knockback(player_position: Vector2):
	# Calculate the direction away from the player
	var knockback_direction = (position - player_position).normalized()
	# Apply the knockback velocity in the opposite direction of the player
	knockback_velocity = knockback_direction * knockback_force
	is_knocked_back = true
	print("Knockback applied!")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area == player_area_2d):
		SPEED *= 1
		mob_animated_sprite_2d.play("attack_right")
		#print("_on_area_2d_area_entered(")



func _on_area_2d_area_exited(body: Node2D) -> void:
	SPEED = 10.0
	mob_animated_sprite_2d.play("fly_right")
	


func _physics_process(delta: float) -> void:
	# Add the gravity.
	player_position = player.position
	mob_position = (player_position - position).normalized()
	
	# for chesing Player by Mob in a range
	if position.distance_to(player_position) <= chase_radius:
		
		if position.distance_to(player_position) <= distance_offset_with_mob:
			SPEED = 0
		else:
			SPEED = 10.0
		position += mob_position * SPEED * delta
	else:
		SPEED = 0
		
	#moving Mob in the direction of Player 
	if player_position.x < position.x:
		mob_animated_sprite_2d.flip_h = true
	else:
		mob_animated_sprite_2d.flip_h = false
		#print("false")
	rotation_degrees = wrap(rotation_degrees , 0 , 360)
	
	if(Input.is_action_just_released("mouse_left") and has_entered and player.weapon_equipped):
		
		apply_knockback(player.position)
		
	if is_knocked_back:
		# Apply knockback effect
		await get_tree().create_timer(0.1).timeout
		position += knockback_velocity * delta
		knockback_velocity = lerp(knockback_velocity, Vector2.ZERO, 5 * delta)  # Reduce knockback gradually
		if knockback_velocity.length() < 10:
			# Stop the knockback when the velocity is almost zero
			is_knocked_back = false
			print("Knockback ended!")


	


func _on_knock_bat_back_area_entered(area: Area2D) -> void:
	if (area == player_area_2d):
		has_entered = true
		#knock_back = Vector2.RIGHT * 400


func _on_knock_bat_back_area_exited(area: Area2D) -> void:
	if(area == player_area_2d):
		has_entered = false
