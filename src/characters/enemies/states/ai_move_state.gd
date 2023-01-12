class_name AIMoveState
extends MoveState

@export var follow_state: MoveState
@export var chase_state: MoveState
@export var search_state: MoveState
@export var return_state: MoveState
@export var attack_state: AIState


func input(event: InputEvent) -> BaseState:
	return null


func physics_process(delta: float) -> BaseState:
	if actor.target:
		return chase_state
	
	return null


func apply_movement() -> void:
	actor.move_and_slide()
