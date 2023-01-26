class_name BaseCharacter
extends CharacterBody2D

@onready var animations = $AnimationPlayer
@onready var states = $StateManager
@onready var state_label = $StateLabel

var move_modifier: float = 1.0
var is_dead: bool = false


func _ready() -> void:
	is_dead = false
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	states.init(self)


func _physics_process(delta: float) -> void:	
	states.physics_process(delta)


func _process(delta: float) -> void:
	states.process(delta)


func death() -> void:
	is_dead = true
	$ViewLight.visible = false
	# Disable collision for corpses
	self.set_collision_layer_value(1, false)
