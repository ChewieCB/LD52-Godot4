class_name MoveState
extends BaseState

@export var move_speed: float = 250
@export var max_speed: float = 400

@export var idle_state: MoveState
@export var walk_state: MoveState

var input_vector: Vector2


func input(event: InputEvent) -> BaseState:
	return null


func physics_process(delta: float) -> BaseState:
	input_vector = get_movement_input()

	return null

func get_movement_input() -> Vector2:
	var _input_vector = Input.get_vector(
		"move_left", "move_right", 
		"move_up", "move_down"
	)
	return _input_vector.normalized()


func apply_friction(amount: float) -> void:
	if player.velocity.length() > amount:
		player.velocity -= player.velocity.normalized() * amount
	else:
		player.velocity = Vector2.ZERO


func apply_acceleration(acceleration: Vector2) -> void:
	player.velocity += acceleration
	player.velocity = player.velocity.limit_length(max_speed)


func apply_movement() -> void:
	player.move_and_slide()
	player.look_at(player.get_global_mouse_position())
