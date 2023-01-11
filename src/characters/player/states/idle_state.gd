extends MoveState

@export var friction: float = 250


func enter() -> void:
	super.enter()


func physics_process(delta: float) -> BaseState:
	input_vector = get_movement_input()
	
	apply_friction(friction)
	apply_movement()
	
	if input_vector != Vector2.ZERO:
		return walk_state
	
	return null
