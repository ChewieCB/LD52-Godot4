class_name BaseState
extends Node

@export var animation_name: String

# Pass in a reference to the player's kinematic body so that it can be used by the state
var player: Player:
	set(val):
		player = val
		for child in get_children():
			child.player = player
			

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
