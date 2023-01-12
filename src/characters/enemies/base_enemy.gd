class_name BaseEnemy
extends BaseCharacter

@export @onready var player: Player
@export @onready var target_node: Node
var target: Vector2
@onready var _agent = $NavigationAgent2D
@onready var initial_position := self.global_position
@onready var initial_rotation := self.global_rotation
@onready var viewcone = $ViewCone

var distance_to_target: float
var next_location: Vector2
var can_chase: bool = false


func _ready() -> void:
	super._ready()
	if target_node:
		target = target_node.global_position
	if target:
		_agent.set_target_location(target)


func _process(_delta: float) -> void:
	queue_redraw()


func _physics_process(delta: float) -> void:
	# If we have a target_node, lock on to it's current position
	if target_node:
		target = target_node.global_position
	# If we have a target, move towards it
	if target:
		distance_to_target = _agent.distance_to_target()
		can_chase = _agent.is_target_reachable() and not _agent.is_target_reached()
		next_location = _agent.get_next_location()
	
	# If we're too close, stop trying to get closer
#	if target_node and distance_to_target < 48:
#		return
	
	_agent.set_target_location(target)
	
	states.physics_process(delta)


#func _on_view_cone_body_entered(body):
#	if body is Player:
#		target_node = body
#		states.change_state($StateManager/MoveState/ChaseState)
#
#
#
#func _on_view_cone_body_exited(body):
#	if body is Player:
#		states.change_state($StateManager/MoveState/ReturnState)
