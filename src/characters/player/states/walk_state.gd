extends MoveState

@export var acceleration: float = 2000


func enter() -> void:
	super.enter()


func physics_process(delta: float) -> BaseState:
	input_vector = get_movement_input()
	
	apply_acceleration(input_vector * acceleration * delta)
	apply_movement()
	
	if input_vector == Vector2.ZERO:
		return idle_state
	
	return null

