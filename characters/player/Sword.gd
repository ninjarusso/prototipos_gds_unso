extends Area2D

@onready var damage : float = get_parent().damage
@export var player : Player
@export var facing_polygon : FacingCollisionPolygon2D

func _ready():
	monitoring = false
	player.connect("facing_direction_changed", _on_player_facing_direction_changed)

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			child.hit(damage, direction_to_damageable)

func _on_player_facing_direction_changed(facing_right : bool):
	if facing_right:
		facing_polygon.scale = facing_polygon.facing_right_scale
	else:
		facing_polygon.scale = facing_polygon.facing_left_scale
