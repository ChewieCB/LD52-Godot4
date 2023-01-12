extends AIMoveState

@export var friction: float = 250


func enter() -> void:
	pass


func physics_process(delta: float) -> BaseState:
	if actor.viewcone.overlaps_body(actor.player):
		actor.target_node = actor.player
		return chase_state
	
	apply_friction(friction)
	apply_movement()
	
	return null
