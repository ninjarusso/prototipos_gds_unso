extends CharacterBody2D

class_name Imp

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@onready var player_detection : Area2D = $DetectionArea
@onready var attack_range : Area2D = $AttackRange

@export var health : float = 3.0

var state = states.IDLE
var animation_name : String
var speed : int = 60
var direction : Vector2 = Vector2.ZERO

var player = null
var player_chase : bool = false
var player_in_range : bool = false

enum states{
	IDLE,
	RUN,
	ATTACK,
	HIT,
	DEATH
}

var list_states = []

func _ready():
	animation_tree.active = true
	
	for i in states:
		list_states.append(states)
		
func _physics_process(delta):
	if player_chase:
		direction = position.direction_to(player.position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		
	if player_chase:
		state = states.RUN
	if player_in_range:
		state = states.ATTACK
	
	move_and_slide()
	update_facing_direction()
#	update_animation_parameters()
	handle_states()

#func update_animation_parameters():
#	if(velocity == Vector2.ZERO):
#		animation_tree["parameters/conditions/idle"] = true
#		animation_tree["parameters/conditions/is_moving"] = false
#	else:
#		animation_tree["parameters/conditions/idle"] = false
#		animation_tree["parameters/conditions/is_moving"] = true

func update_facing_direction():
	if direction.x < 0 && !state == states.ATTACK:
		sprite.flip_h = false
	elif direction.x > 0 && !state == states.ATTACK:
		sprite.flip_h = true
		
func handle_states():
	match state:
		states.IDLE:
			animation_tree["parameters/conditions/idle"] = true
			animation_tree["parameters/conditions/is_moving"] = false
		states.RUN:
			animation_tree["parameters/conditions/idle"] = false
			animation_tree["parameters/conditions/is_moving"] = true
		states.ATTACK:
			animation_tree["parameters/conditions/attack"] = true
			if animation_tree.animation_finished:
				state = states.IDLE
		states.HIT:
			animation_tree["parameters/conditions/hit"] = true
			if animation_tree.animation_finished:
				state = states.IDLE
		states.DEATH:
			animation_tree["parameters/conditions/is_dead"] = true
			set_physics_process(false)


func _on_detection_area_body_entered(body):
	if body is Player:
		player = body
		player_chase = true

func _on_attack_range_body_entered(body):
	if body is Player:
		player_in_range = true

func _on_attack_range_body_exited(body):
	if body is Player:
		player_in_range = false

func _on_detection_area_body_exited(body):
	if body is Player:
		player = null
		player_chase = false

func hit(damage : float):
	if health > 0:
		print("Imp takes " + str(damage) + "damage")
		state = states.HIT
		health -= damage
	else:
		state = states.DEATH


