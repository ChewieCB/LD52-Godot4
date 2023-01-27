extends AIMoveState

@export var acceleration: float = 2000


func enter() -> void:
	actor.animations.play("alert")


func exit() -> void:
	actor.animations.play("lost")


func physics_process(delta: float) -> BaseState:
	if actor.target == Vector2.ZERO:
		return search_state
	
	if actor.distance_to_target < 32 and actor.target_node:
		return attack_state
	
	if not actor.can_chase:
		return search_state
	
	if actor.target_node and actor.target_node.is_dead:
		return return_state
	
	var direction := actor.global_position.direction_to(actor.next_location)
	actor.pivot.global_rotation = direction.angle()
	var desired_velocity := direction * 200.0
	var steering := (desired_velocity - actor.velocity) * delta * 4.0
	apply_acceleration(steering)
	apply_movement()
	
	return null

