extends CharacterBody2D

class_name Player

signal facing_direction_changed(facing_right : bool)

@export var speed : float = 200.0
@export var direction : Vector2 = Vector2.ZERO
@export var dash_speed : float = 1
@export var damage : float = 1

@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down")
	if direction && state_machine.check_if_can_move():
		velocity = (direction * speed) * dash_speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	update_facing_direction()
	update_animation_parameters()

func update_animation_parameters():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		
func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	emit_signal("facing_direction_changed", !sprite.flip_h)
