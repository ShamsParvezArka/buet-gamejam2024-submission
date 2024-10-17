extends CharacterBody2D

@export var speed := 70
@onready var state_machine := $AnimatedSprite2D
@onready var chest: StaticBody2D = $"../Chest"
@onready var audio_run: AudioStreamPlayer2D = $AudioRun
@onready var audio_sowrd_swing: AudioStreamPlayer2D = $AudioSowrdSwing
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var puzzle: Node2D = $"../Puzzle"
@onready var canvas_modulate: CanvasModulate = $"../CanvasModulate"
@onready var helper: Node2D = $Camera2D/Helper
@onready var helper_sprite: Sprite2D = $Camera2D/Helper/HelperSprite

var can_move := true
var teleport := false
var has_sowrd := false
var is_played := false
var weapon_equipped := false
var attacking := false
var is_facing_left:= false
var switches := true
var is_dead := false
var level := 0
var end := false

var last_saved_pos := Vector2.ZERO
var level1_spos := Vector2(1241, 528)

func animate_sprite() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		state_machine.flip_h = false
		is_facing_left = false
		collision_shape_2d.position.x = 11
	elif direction < 0:
		state_machine.flip_h = true
		collision_shape_2d.position.x = -13
		is_facing_left = true
	
	var movement := Input.get_vector("move_right", "move_left", "move_down", "move_up")

	if weapon_equipped:
		if movement and !attacking:
			state_machine.play("sowrd_run")
		elif Input.is_action_just_pressed("mouse_left") and !attacking:
			attacking = true
			if !audio_sowrd_swing.playing:
				audio_sowrd_swing.play()
			collision_shape_2d.scale = Vector2(1.4, 1.4)
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
	
	if weapon_equipped:
		helper_sprite.frame_coords.y = 1
	else:
		helper_sprite.frame_coords.y = 0
	
	if can_move:
		animate_sprite()


func _ready() -> void:
	$Camera2D.enabled = true
	$"../VoidSpaceCutScene/Path2D/PathFollow2D/Camera2D".enabled = false
	$"../FridgeCutScene/Path2D/PathFollow2D/Camera2D".enabled = false


func _process(delta: float) -> void:
	if chest.is_sowrd_obtained:
		helper.visible = true
	switches = true
	for i in puzzle.get_children():
		switches = switches and i.on


func _physics_process(delta: float) -> void:
	if can_move:
		move_and_slide()
	elif !can_move and is_dead:
		state_machine.play("dead")
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
		collision_shape_2d.scale = Vector2(1.1, 1.1)
		
	elif state_machine.animation == "teleport" and !end:
		teleport = false
		position = level1_spos
		state_machine.play("spawn")
		can_move = true
	
	elif state_machine.animation == "teleport" and end:
		position = Vector2(120, 132)
		get_tree().change_scene_to_file("res://scenes/the_end.tscn")
	
	elif state_machine.animation == "spawn":
		state_machine.play("idle")
		
	elif state_machine.animation == "dead":
		is_dead = false
		weapon_equipped = false
		if last_saved_pos == Vector2.ZERO:
			position = level1_spos
		elif last_saved_pos != Vector2.ZERO:
			position = last_saved_pos
		state_machine.play("spawn")
		can_move = true
