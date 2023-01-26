extends AIMoveState


func enter() -> void:
	var map = NavigationServer2D.agent_get_map(actor._agent)
	if actor.target_node:
		var closest_point = NavigationServer2D.map_get_closest_point(map, actor.last_seen_player)
	#	# Move the closest point a bit closer to the enemy for safety
		closest_point += closest_point.direction_to(actor.global_position) * 32
		if actor._agent.is_target_reachable():
			actor.target = closest_point
		actor.target_node = null


func exit() -> void:
	actor.last_seen_player = Vector2()


func physics_process(delta: float) -> BaseState:
	if actor.target_node:
		return chase_state
	
	if actor._agent.is_navigation_finished() or not actor.can_chase:
		var _temp =  await search()
		return return_state
	
	var direction := actor.global_position.direction_to(actor.next_location)
	actor.global_rotation = direction.angle()
	var desired_velocity := direction * 160.0
	var steering := (desired_velocity - actor.velocity) * delta * 4.0
	apply_acceleration(steering)
	apply_movement()
	
	return null


func search() -> AIMoveState:
#	var original_rotation = actor.global_rotation
#	# Rotate 45 deg left
#	actor.global_rotation = original_rotation - deg_to_rad(90)
#	await get_tree().create_timer(2.0).timeout
#	# Rotate back to center
#	actor.global_rotation = original_rotation
#	await get_tree().create_timer(2.0).timeout
#	# Rotate 45 deg right
#	actor.global_rotation = original_rotation + deg_to_rad(90)
	await get_tree().create_timer(5.0).timeout
	
	return return_state

