extends AIMoveState

@export var friction: float = 250

var curve: Curve2D

var path_index: int = 0
var path_points: Array


func enter() -> void:
	curve = actor.follow_path.curve
	actor.target_node = null
	#
	path_points = Array(actor.follow_path.curve.get_baked_points())
	# Find the closest point that the character can enter the path
#	var closest_point = curve.get_closest_point(actor.global_position)
#	var closest_point_offset = curve.get_closest_offset(closest_point)
#	var closest_point_index = get_curve_point_index_from_offset(closest_point_offset)
#	# 
#	path_index = closest_point_index
	actor.target = path_points[path_index]


func physics_process(delta: float) -> BaseState:
	if actor.viewcone.overlaps_body(actor.player):
		actor.target_node = actor.player
		return chase_state
	
	if actor._agent.is_navigation_finished():
		if path_index == path_points.size() - 1:
			path_index = 0
		else:
			path_index += 1
		print(actor.name, " : ", path_index)
		actor.target = path_points[path_index]
	else:
		var direction := actor.global_position.direction_to(actor.next_location)
		actor.global_rotation = direction.angle()
		var desired_velocity := direction * 150.0
		var steering := (desired_velocity - actor.velocity) * delta * 4.0
		apply_acceleration(steering)
		apply_movement()
	
	return null


func get_curve_point_index_from_offset(offset):
	var curve_point_length = curve.get_point_count()
	if curve_point_length < 2: return curve_point_length
	for i in range(1, curve.get_point_count()):
		var current_point_offset = curve.get_closest_offset(curve.get_point_position(i))
		if current_point_offset > offset: 
			return i
	return curve_point_length
