extends AIState

@onready var timer := $AttackDelayTimer
@export var move_state: AIMoveState

var timer_finished: bool


func enter() -> void:
	timer_finished = false
	timer.start()


func exit() -> void:
	timer.stop()


func input(event: InputEvent) -> BaseState:
	return null


func physics_process(delta: float) -> BaseState:
	if actor.distance_to_target > 120:
		return move_state.chase_state
	
	if timer_finished:
		return move_state.idle_state
	
	return null


func _on_attack_delay_timer_timeout():
	if actor.target:
		actor.target.death()
	timer_finished = true
	
