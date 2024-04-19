extends Label

@export var state_machine : CharacterStateMachine
@export var damageable : Damageable

func _process(delta):
	text = "State: " + state_machine.current_state.name + "
	Health: " + str(damageable.health)
