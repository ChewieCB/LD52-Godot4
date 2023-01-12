extends AIMoveState

@export var friction: float = 250


func enter() -> void:
	pass


func physics_process(delta: float) -> BaseState:
	if actor.distance_to_target > 120:
		return chase_state
	
	apply_friction(friction)
	apply_movement()
	
	return null
