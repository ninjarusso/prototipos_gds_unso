extends State

class_name DashState

@export var base_state : State

@onready var timer : Timer = $DashTimer

func on_enter():
	timer.start()

func _on_dash_timer_timeout():
	animation_tree["parameters/conditions/dash"] = false
	character.dash_speed = 1
	next_state = base_state
