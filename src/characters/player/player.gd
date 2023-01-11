class_name Player
extends CharacterBody2D

#@onready var animations = $animations
@onready var states = $StateManager
@onready var state_label = $StateLabel

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	states.init(self)


func _unhandled_input(event: InputEvent) -> void:
	states.input(event)


func _physics_process(delta: float) -> void:
	# Debug reset/quit inputs
	if Input.is_action_pressed("reset"):
		var _ret = get_tree().reload_current_scene()
	elif Input.is_action_pressed("quit"):
		get_tree().quit()
	
	states.physics_process(delta)


func _process(delta: float) -> void:
	states.process(delta)
