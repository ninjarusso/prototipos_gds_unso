extends Node

class_name Damageable

signal on_hit(node_hit : Node, damage_taken : float, knockback_direction : Vector2)

@export var state_machine : CharacterStateMachine

@export var animation_tree : AnimationTree
@export var health : float = 3.0 :
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

func hit(damage : float, knockback_direction : Vector2):
	if(state_machine.check_if_can_take_damage()):
		health -= damage
		animation_tree["parameters/conditions/hit"] = true
	
	emit_signal("on_hit", get_parent(), damage, knockback_direction)
	
	if(health <= 0):
		pass
