extends AIMoveState

@export var acceleration: float = 2000


func enter() -> void:
	pass


func physics_process(delta: float) -> BaseState:
	if actor.distance_to_target < 60:
		return idle_state
	
	if actor._agent.is_navigation_finished():
		await(get_tree().create_timer(1.0))
	
	if actor.can_chase:
		var direction := actor.global_position.direction_to(actor.next_location)
		actor.global_rotation = direction.angle()
		var desired_velocity := direction * 400.0
		var steering := (desired_velocity - actor.velocity) * delta * 4.0
		apply_acceleration(steering)
		apply_movement()
	else:
		return idle_state
	
	return null

