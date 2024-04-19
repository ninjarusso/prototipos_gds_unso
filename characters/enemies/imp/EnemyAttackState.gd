extends State

class_name EnemyAttackState

@export var attack_range : Area2D
@export var damage : float = 1
@export var base_state : State
@export var attack_animation : String = "attack"
	
@onready var buffer_timer : Timer = $BufferTimer

var player
var player_direction

func _on_attack_area_2d_body_in_attack_range(damageable, position):
	if damageable.health > 0:
		emit_signal("interrupt_state", self)
		if(buffer_timer.is_stopped()):
			animation_tree["parameters/conditions/attack"] = true
			player = damageable
			player_direction = position
	
func attack(damageable : Damageable, position : Vector2):
	damageable.hit(damage, position)
		
func _on_attack_area_2d_body_out_of_attack_range():
	animation_tree["parameters/conditions/attack"] = false
	emit_signal("interrupt_state", base_state)

func _on_animation_tree_animation_started(anim_name):
	if(anim_name == attack_animation):
		attack(player, player_direction)
		buffer_timer.start()
