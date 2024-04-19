extends State

class_name AttackState

@onready var attack_timer : Timer = $AttackTimer

@export var base_state : State
@export var attack1_animation : String = "attack1"
@export var attack2_animation : String = "attack2"
@export var attack3_animation : String = "attack3"

func state_input(event : InputEvent):
	if(event.is_action_pressed("attack")):
		attack_timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == attack1_animation):
		if(attack_timer.is_stopped()):
			next_state = base_state
		else:
			animation_tree["parameters/playback"].travel(attack2_animation)
	if(anim_name == attack2_animation):
		if(attack_timer.is_stopped()):
			next_state = base_state
		else:
			animation_tree["parameters/playback"].travel(attack3_animation)
	if(anim_name == attack3_animation):
			next_state = base_state
