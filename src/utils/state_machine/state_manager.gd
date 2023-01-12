class_name StateManager
extends Node

@onready @export var starting_state: BaseState

var actor: CharacterBody2D
var current_state: BaseState


func change_state(new_state: BaseState) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()
	
	if actor:
		actor.state_label.text = current_state.name


# Initialize the state machine by giving each state a reference to the objects
# owned by the parent that they should be able to take control of
# and set a default state
func init(_actor: CharacterBody2D) -> void:
	actor = _actor
	for child in get_children():
		child.actor = _actor

	# Initialize with a default state of idle
	change_state(starting_state)


# Pass through functions for the Player to call,
# handling state changes as needed
func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)


func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state:
		change_state(new_state)


func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)
