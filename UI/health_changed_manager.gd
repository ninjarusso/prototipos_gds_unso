extends Control

@export var health_changed_label : PackedScene
@export var damage_color : Color = Color.RED
@export var heal_color : Color = Color.GREEN

func _ready():
	SignalBus.connect("on_health_changed", on_signal_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_signal_health_changed(changed_node : Node, changed_amount : float):
	var label_instance : Label = health_changed_label.instantiate()
	changed_node.add_child(label_instance)
	label_instance.text = str(changed_amount)
	
	if(changed_amount >= 0):
		label_instance.modulate = heal_color
	else:
		label_instance.modulate = damage_color
