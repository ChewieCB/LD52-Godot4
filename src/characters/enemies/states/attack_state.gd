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
	
	var direction := actor.global_position.direction_to(actor.target)
	actor.pivot.global_rotation = direction.angle()
	
	return null


func _on_attack_delay_timer_timeout():
	if actor.target_node:
		actor.animations.play("attack_hit")
		actor.target_node.death()
	else:
		actor.animations.play("attack")
	await actor.animations.animation_finished
	timer_finished = true
	
