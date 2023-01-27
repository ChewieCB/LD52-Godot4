extends BaseState


func enter() -> void:
	actor.blood.restart()


func physics_process(_delta: float) -> BaseState:

	return null
