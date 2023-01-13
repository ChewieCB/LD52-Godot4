extends AIMoveState

@export var acceleration: float = 2000

var has_lost_player: bool = false


func enter() -> void:
	pass


func physics_process(delta: float) -> BaseState:
	if not actor.viewcone.overlaps_body(actor.player):
		return search_state
	
	if actor.distance_to_target < 60:
		return attack_state
	
	if not actor.can_chase or \
	not actor.target_node or \
	(actor.target_node and actor.target_node.is_dead):
		return return_state
	else:
		var direction := actor.global_position.direction_to(actor.next_location)
		actor.global_rotation = direction.angle()
		var desired_velocity := direction * 400.0
		var steering := (desired_velocity - actor.velocity) * delta * 4.0
		apply_acceleration(steering)
		apply_movement()
	
	return null
