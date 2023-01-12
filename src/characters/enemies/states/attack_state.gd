extends AIState

@onready var timer := $AttackDelayTimer
@export var move_state: AIMoveState

var timer_finished: bool = false


func enter() -> void:
	timer.start()


func exit() -> void:
	timer.stop()


func input(event: InputEvent) -> BaseState:
	return null


func physics_process(delta: float) -> BaseState:
	if actor.distance_to_target > 120:
		return move_state.chase_state
	
	if timer_finished:
		timer_finished = false
		return move_state.return_state
	
	return null


func _on_attack_delay_timer_timeout():
	if actor.target_node:
		actor.target_node.death()
	timer_finished = true
	
