class_name Player
extends BaseCharacter


func _physics_process(delta: float) -> void:
	# Debug reset/quit inputs
	if Input.is_action_pressed("reset"):
		var _ret = get_tree().reload_current_scene()
	elif Input.is_action_pressed("quit"):
		get_tree().quit()
	
	states.physics_process(delta)
