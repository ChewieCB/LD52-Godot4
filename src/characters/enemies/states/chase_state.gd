extends AIMoveState

@export var acceleration: float = 2000


func enter() -> void:
	pass


func physics_process(delta: float) -> BaseState:
	if actor.distance_to_target < 60:
		return attack_state
	
	if actor._agent.is_navigation_finished():
		await(get_tree().create_timer(1.0))
	
	if not actor.can_chase or actor.is_dead:
		return idle_state
	else:
		var direction := actor.global_position.direction_to(actor.next_location)
		actor.global_rotation = direction.angle()
		var desired_velocity := direction * 400.0
		var steering := (desired_velocity - actor.velocity) * delta * 4.0
		apply_acceleration(steering)
		apply_movement()
	
	return null

