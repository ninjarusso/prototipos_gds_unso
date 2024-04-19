extends State

class_name BaseState

@export var dash_state : State
@export var attack_state : State
@export var attack1_animation : String = "attack1"

@onready var buffer_timer : Timer = $BufferTimer

func state_input(event : InputEvent):
	if(buffer_timer.is_stopped()):
		if(event.is_action_pressed("dash")):
			dash()
		if(event.is_action_pressed("attack")):
			attack()
		
func dash():
	character.dash_speed = 2
	animation_tree["parameters/conditions/dash"] = true
	next_state = dash_state

func attack():
	animation_tree["parameters/playback"].travel(attack1_animation)
	next_state = attack_state
