extends MoveState

@export var acceleration: float = 1000


func enter() -> void:
	super.enter()
	actor.audio_player.play()


func physics_process(delta: float) -> BaseState:
	if actor.is_dead:
		return death_state
	
	input_vector = get_movement_input()
	
	apply_acceleration(input_vector * acceleration * delta)
	apply_movement()
	
	if input_vector == Vector2.ZERO:
		return idle_state
	
	return null

