class_name BaseState
extends Node

@export var animation_name: String

@export var death_state: BaseState


# Pass in a reference to the actor's kinematic body so that it can be used by the state
var actor: CharacterBody2D:
	set(val):
		actor = val
		for child in get_children():
			if child is BaseState:
				child.actor = actor


func enter() -> void:
#	player.animations.play(animation_name)
	pass


func exit() -> void:
	pass


func input(event: InputEvent) -> BaseState:
	return null


func process(delta: float) -> BaseState:
	return null


func physics_process(delta: float) -> BaseState:
	return null
