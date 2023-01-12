class_name BaseEnemy
extends BaseCharacter

@export var target: Node2D

@onready var _agent = $NavigationAgent2D

var distance_to_target: float
var next_location: Vector2
var can_chase: bool = false


func _ready() -> void:
	super._ready()
	if target:
		_agent.set_target_location(target.global_position)


func _physics_process(delta: float) -> void:
	if target:
		distance_to_target = global_position.distance_to(target.global_position)
		can_chase = _agent.is_target_reachable() and not _agent.is_target_reached()
		next_location = _agent.get_next_location()
	
	if distance_to_target < 48:
		return
	_agent.set_target_location(target.global_position)
	
#	if global_position.distance_to(target_location.global_position) < 48:
#		return
#	if _agent.is_navigation_finished():
#		await(get_tree().create_timer(1.0))
#	_agent.set_target_location(target_location.global_position)
#	if _agent.is_target_reachable() and not _agent.is_target_reached():
#		var direction := global_position.direction_to(_agent.get_next_location())
#		global_rotation = direction.angle()
#		var desired_velocity := direction * 400.0
#		var steering := (desired_velocity - velocity) * delta * 4.0
#		velocity += steering
#	else:
#		velocity = Vector2.ZERO
#
#	move_and_slide() 
	states.physics_process(delta)
	
	
	

