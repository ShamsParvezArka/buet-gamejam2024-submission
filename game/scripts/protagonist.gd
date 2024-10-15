extends CharacterBody2D

@export var speed := 50
@onready var state_machine := $AnimatedSprite2D
@onready var f: Node2D = $F
@onready var open: Label = $F/open

var can_move := true
@export var can_open := false
var tp := false
var has_sowrd := false
var is_chest := false
var can_save := false
var is_played := false

@onready var chest: StaticBody2D = $"../Chest"


func animate_sprite() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		state_machine.flip_h = false
	elif direction < 0:
		state_machine.flip_h = true
	
	var movement := Input.get_vector("move_right", "move_left", "move_down", "move_up")
	
	if (movement):
		state_machine.play("run")
	else:
		state_machine.play("idle")
		

func _input(event: InputEvent) -> void:
	var input_vec := Vector2.ZERO
	
	input_vec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vec.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vec.normalized()
	
	velocity = (input_vec * speed) if input_vec else input_vec
	
	if can_move == true:
		animate_sprite()
	elif tp == true:
		state_machine.play("teleport")
	else:
		state_machine.play("idle")
		
	if is_chest and Input.is_action_just_pressed("key_f"):
		can_open = true


func _ready() -> void:
	$Camera2D.enabled = true
	$"../VoidSpaceCutScene/Path2D/PathFollow2D/Camera2D".enabled = false
	$"../FridgeCutScene/Path2D/PathFollow2D/Camera2D".enabled = false


func _physics_process(delta: float) -> void:
	if can_save == true:
		open.text = "save"
		f.visible = true	
	elif is_chest == true:
		open.text = "open"
		f.visible = true
	else:
		f.visible = false
	
	
	if can_move == true:
		move_and_slide()
