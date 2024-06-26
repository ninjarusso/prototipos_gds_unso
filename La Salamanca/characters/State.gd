extends Node

class_name State

signal interrupt_state(new_state : State)

@export var can_move : bool = true
@export var can_take_damage : bool = true

var character : CharacterBody2D
var next_state : State
var animation_tree : AnimationTree

func state_process(delta):
	pass
	
func state_input(event : InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass
