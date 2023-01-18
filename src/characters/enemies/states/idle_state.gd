extends AIMoveState

@export var friction: float = 250


func enter() -> void:
	pass


func physics_process(delta: float) -> BaseState:
	if actor.target_node:
		return chase_state
	
	if actor.is_following:
		return follow_state
	
	apply_friction(friction)
	apply_movement()
	
	return null

