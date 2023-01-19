class_name BaseEnemy
extends BaseCharacter

@export @onready var player: Player
@export @onready var target_node: Node
@export @onready var follow_path: Path2D
@export var is_following: bool = false
var target: Vector2
@onready var _agent = $NavigationAgent2D
@onready var initial_position := self.global_position
@onready var initial_rotation := self.global_rotation
@onready var viewcone = $ViewCone

var distance_to_target: float
var next_location: Vector2
var can_chase: bool = false
var nav_path

var space_state

var last_seen_player: Vector2


func _ready() -> void:
	super._ready()
	if target_node:
		target = target_node.global_position
	if target:
		_agent.set_target_location(target)
		last_seen_player = target


func _draw() -> void:
	if target:
		draw_circle(to_local(target), 8.0, Color.RED)
#		if nav_path:
#			for idx in range(nav_path.size() - 2):
#				if idx == 0:
#					draw_line(position, to_local(nav_path[idx]), Color.RED, 2.0)
#				else:
#					draw_line(to_local(nav_path[idx-1]), to_local(nav_path[idx]), Color.RED, 2.0)
	if last_seen_player:
		draw_circle(to_local(last_seen_player), 8.0, Color.PURPLE)


func _process(_delta: float) -> void:
	queue_redraw()


func _physics_process(delta: float) -> void:
	space_state = get_world_2d().direct_space_state
	
	# If we have a target_node, lock on to it's current position
	if target_node:
		target = target_node.global_position
	# If we have a target, move towards it
	if target:
		distance_to_target = _agent.distance_to_target()
		can_chase = _agent.is_target_reachable() and not _agent.is_target_reached()
		next_location = _agent.get_next_location()
		nav_path = _agent.get_current_navigation_path()
	
	# If we're too close, stop trying to get closer
#	if target_node and distance_to_target < 48:
#		return
	
	_agent.set_target_location(target)
	
	states.physics_process(delta)


func _on_view_cone_body_exited(body):
	if body is Player:
		var exit_position: Vector2
		# Check if the point collides with anything
		var query = PhysicsRayQueryParameters2D.create(
			global_position, 
			body.global_position, 
			0b1010, 
			[get_rid()]
		)
		var result = space_state.intersect_ray(query)
		if result:
			# Add the point where the ray collides
			exit_position = result["position"]
		# Move the closest point a bit closer to the enemy to keep it in bounds
		exit_position += exit_position.direction_to(global_position) * 8
		last_seen_player = exit_position
		target_node = null


func _on_view_cone_body_entered(body):
	if body is Player:
		target_node = body
