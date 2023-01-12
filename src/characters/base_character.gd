class_name BaseCharacter
extends CharacterBody2D

#@onready var animations = $animations
@onready var states = $StateManager
@onready var state_label = $StateLabel


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	states.init(self)


func _physics_process(delta: float) -> void:	
	states.physics_process(delta)


func _process(delta: float) -> void:
	states.process(delta)
