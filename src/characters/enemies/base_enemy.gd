extends CharacterBody2D

@export var target_location: Node2D

@onready var _agent = $NavigationAgent2D


func _ready() -> void:
	_agent.set_target_location(target_location.global_position)


func _physics_process(delta: float) -> void:
	if _agent.is_navigation_finished():
		await(get_tree().create_timer(1.0))
	_agent.set_target_location(target_location.global_position)
	if _agent.is_target_reachable() and not _agent.is_target_reached():
		var direction := global_position.direction_to(_agent.get_next_location())
		global_rotation = direction.angle()
		var desired_velocity := direction * 360.0
		var steering := (desired_velocity - velocity) * delta * 4.0
		velocity += steering
	else:
		velocity = Vector2.ZERO
	
	move_and_slide() 
	
	
	

