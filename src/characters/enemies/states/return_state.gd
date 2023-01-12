extends AIMoveState

@export var friction: float = 250


func enter() -> void:
	super.enter()


func input(event: InputEvent) -> BaseState:
	return null


func physics_process(delta: float) -> BaseState:
	apply_friction(friction)
	apply_movement()
	
	return null
