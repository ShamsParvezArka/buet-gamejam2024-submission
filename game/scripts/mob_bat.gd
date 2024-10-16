extends CharacterBody2D


var SPEED = 20.0
@export var chase_radius = 100
var distance_offset_with_mob = 17

var player_position
var mob_position 
var is_retreating = false 
var retreat_distance = 10
var mob_is_facing_left := true
var mob_life = 3
var is_damaged = false
@onready var player: CharacterBody2D = $"../Protagonist"
#@onready var player: CharacterBody2D = $"../../Protagonist"
@onready var mob_animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_area_2d: Area2D = player.get_node("Area2D")

#KNCOK-BACK variables
var knockback_force = 200  # Adjust the knockback force as needed
var is_knocked_back = false
var knockback_velocity: Vector2

var has_entered = false

func _ready() -> void:
	mob_animated_sprite_2d.play("fly_right")
	
	
func apply_knockback(player_position: Vector2):
	if is_facing_player(player):
		# Calculate the direction away from the player
		var knockback_direction = (position - player_position).normalized()
		# Apply the knockback velocity in the opposite direction of the player
		knockback_velocity = knockback_direction * knockback_force
		is_knocked_back = true
		is_damaged = true
		
		if mob_life > 0:
			mob_life -= 1
			

func is_facing_player(player: Node2D) -> bool:
	var player_on_right = player.position.x > position.x
	var is_facing_right = velocity.x > 0  # Bird is moving right if velocity.x > 0

	# Check if player is in front of the bird based on current velocity
	if player_on_right and player.is_facing_left:
		
		return true
	elif not player_on_right and not player.is_facing_left:  # Bird is facing left, player is on left
		return true
	return false
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area == player_area_2d):
		SPEED *= 1
		if not is_damaged:
			mob_animated_sprite_2d.play("attack_right")
		has_entered = true


func _on_area_2d_area_exited(body: Node2D) -> void:
	SPEED = 10.0
	if not is_damaged:
		mob_animated_sprite_2d.play("fly_right")
	elif is_damaged:
		mob_animated_sprite_2d.stop()
		mob_animated_sprite_2d.play("damage_right")
	has_entered = false
	
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if mob_animated_sprite_2d.animation == "damage_right":
		mob_animated_sprite_2d.play("fly_right")
		
		if mob_life == 0:
			queue_free()
			

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
	
	if (Input.is_action_just_pressed("mouse_left") and has_entered and player.weapon_equipped):
		if(player.scale.x == self.scale.x ):
			apply_knockback(player.position)

	if is_knocked_back:
		# Apply knockback effect
		await get_tree().create_timer(.1).timeout
		position += knockback_velocity * delta
		knockback_velocity = lerp(knockback_velocity, Vector2.ZERO, 5 * delta)  # Reduce knockback gradually
		if knockback_velocity.length() < 10:
			# Stop the knockback when the velocity is almost zero
			is_knocked_back = false
			is_damaged = false
		
