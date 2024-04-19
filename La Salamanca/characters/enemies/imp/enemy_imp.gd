extends CharacterBody2D

@export var animation_tree : AnimationTree
@export var speed : float = 60.0
@export var direction : Vector2 = Vector2.ZERO
@export var sprite : Sprite2D
@export var hit_state : State

@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

var player_chase = false
var player = null

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	if player_chase && state_machine.check_if_can_move():
		direction = position.direction_to(player.position).normalized()
		velocity = direction * speed
	elif state_machine.current_state != hit_state:
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
	if direction.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true

func _on_area_2d_body_exited(body):
	player = null
	player_chase = false
