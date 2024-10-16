extends CharacterBody2D

@export var speed := 50
@onready var state_machine := $AnimatedSprite2D
@onready var chest: StaticBody2D = $"../Chest"
@onready var audio_run: AudioStreamPlayer2D = $AudioRun
@onready var audio_sowrd_swing: AudioStreamPlayer2D = $AudioSowrdSwing

var can_move := true
var teleport := false
var has_sowrd := false
var is_played := false
var weapon_equipped := false
var attacking := false


func animate_sprite() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		state_machine.flip_h = false
	elif direction < 0:
		state_machine.flip_h = true
	
	var movement := Input.get_vector("move_right", "move_left", "move_down", "move_up")

	if weapon_equipped:
		if movement and !attacking:
			state_machine.play("sowrd_run")
		elif Input.is_action_just_pressed("mouse_left") and !attacking:
			attacking = true
			if !audio_sowrd_swing.playing:
				audio_sowrd_swing.play()
			state_machine.play("idle_and_swing")
			
		elif !movement and !attacking:
			state_machine.play("sowrd_idle")
	else:
		if movement:
			state_machine.play("run")
			if !audio_run.playing:
				audio_run.play()
		else:
			state_machine.play("idle")
		


func _input(event: InputEvent) -> void:
	var input_vec := Vector2.ZERO
	
	if can_move:
		input_vec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		input_vec.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		input_vec.normalized()
	
	velocity = (input_vec * speed) if input_vec else input_vec
	
	if Input.is_action_just_pressed("key_x"):
		weapon_equipped = !weapon_equipped
	
	if can_move:
		animate_sprite()


func _ready() -> void:
	$Camera2D.enabled = true
	$"../VoidSpaceCutScene/Path2D/PathFollow2D/Camera2D".enabled = false
	$"../FridgeCutScene/Path2D/PathFollow2D/Camera2D".enabled = false


func _physics_process(delta: float) -> void:
	if can_move:
		move_and_slide()
	elif !can_move and weapon_equipped:
		state_machine.play("sowrd_idle")
	elif !can_move and teleport:
		state_machine.play("teleport")
	else:
		state_machine.play("idle")


func _on_animated_sprite_2d_animation_finished() -> void:
	if state_machine.animation == "idle_and_swing":
		state_machine.play("sowrd_idle")
		attacking = false
	elif state_machine.animation == "teleport":
		print("level finished")
