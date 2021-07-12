extends KinematicBody2D


var motion = Vector2()
var speed = 300

onready var tween = $Tween
puppet var puppet_position = Vector2(0.0, 0.0) setget puppet_position_set


func _process(delta: float) -> void:
	if is_network_master():
		var x_input = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		
		
		motion = Vector2(x_input, 0.0).normalized()
		
		move_and_slide(motion * speed)


func puppet_position_set(new_value) -> void:
	puppet_position = new_value
	tween.interpolate_property(self, "global_position", global_position, puppet_position, 0.1)
	tween.start()
	
func _on_Network_tick_rate_timeout():
	if is_network_master():
		rset_unreliable("puppet_position", global_position)
