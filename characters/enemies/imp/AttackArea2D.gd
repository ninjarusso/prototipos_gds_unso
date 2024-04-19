extends Area2D

class_name AttackArea2D

signal body_in_attack_range(node : Node, position : Vector2)
signal body_out_of_attack_range()

func _on_body_entered(body):
		for child in body.get_children():
			if child is Damageable:
				var direction_to_damageable = body.global_position.normalized()
				emit_signal("body_in_attack_range", child, direction_to_damageable)


func _on_body_exited(body):
	emit_signal("body_out_of_attack_range")
