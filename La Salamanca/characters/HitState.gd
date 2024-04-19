extends State

class_name HitState

@export var damageable : Damageable
@export var dead_state : State
@export var base_state : State
@export var hit_animation_name : String = "hit"
@export var knockback_speed : float = 1.4

func _ready():
	damageable.connect("on_hit", on_damageable_hit)
	
func on_damageable_hit(hit_node, damage_amount : float, knockback_direction : Vector2):
	if(damageable.health > 0):
		emit_signal("interrupt_state", self)
		character.velocity = knockback_direction / knockback_speed
	else:
		emit_signal("interrupt_state", dead_state)
		animation_tree["parameters/conditions/is_dead"] = true


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == hit_animation_name:
		animation_tree["parameters/conditions/hit"] = false
		character.velocity = character.direction * character.speed
		next_state = base_state
