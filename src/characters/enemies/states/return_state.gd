extends AIMoveState

@export var friction: float = 250
var original_target_desired_distance: float


func enter() -> void:
	actor.target_node = null
	actor.target = actor.initial_position
	original_target_desired_distance = actor._agent.target_desired_distance
	actor._agent.target_desired_distance = 1.0


func exit() -> void:
	actor._agent.target_desired_distance = original_target_desired_distance


func input(event: InputEvent) -> BaseState:
	return null


func physics_process(delta: float) -> BaseState:
	if actor._agent.is_navigation_finished():
		return idle_state
	
	if actor.viewcone.overlaps_body(actor.player):
		actor.target_node = actor.player
		return chase_state
	
	var direction := actor.global_position.direction_to(actor.next_location)
	actor.global_rotation = direction.angle()
	var desired_velocity := direction * 400.0
	var steering := (desired_velocity - actor.velocity) * delta * 4.0
	apply_acceleration(steering)
	apply_movement()
	
	return null
