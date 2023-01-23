#@tool
extends Area2D

@export var detection_radius: float = 256
@export var view_angle: int: 
	set(val):
		view_angle = val
@export var FOV: int = 80

@onready var actor = get_parent()

var cell_size = Vector2(16, 16)
var space_state

var view_cone_points: 
	set(val):
		view_cone_points = val
		var new_shape = ConvexPolygonShape2D.new()
		new_shape.points = (view_cone_points)
		$CollisionShape2D.shape = new_shape
var view_cone_points_colors
var view_cone
var draw_colour = Color.GREEN


#func _draw() -> void:
#	if view_cone_points:
#		draw_colour.a = 0.4
#		draw_polygon(view_cone_points, Array([draw_colour]))


func _process(_delta) -> void:
	queue_redraw()


func _physics_process(delta) -> void:
	space_state = get_world_2d().direct_space_state
	view_cone = gen_circle_arc_poly(cell_size/2 + Vector2(-16, -9), detection_radius, view_angle - FOV/2, view_angle + FOV/2)
	view_cone_points = view_cone[0]
	view_cone_points_colors = view_cone[1]


func gen_circle_arc_poly(center, radius, angle_from, angle_to) -> Array:
	var nb_points = 32
	var points_arc = Array()
	var colors = Array()
	points_arc.push_back(center)
	colors.push_back(Color.FOREST_GREEN)
	
	for i in range(nb_points + 1):
		var angle_point = angle_from + i * (angle_to - angle_from) / nb_points
		var _point = center + Vector2(
			cos(deg_to_rad(angle_point)), 
			sin(deg_to_rad(angle_point))
		) * radius
		# Check if the point collides with anything
		var query = PhysicsRayQueryParameters2D.create(to_global(center), to_global(_point), 0b1010, [actor.get_rid()])
		var result = space_state.intersect_ray(query)
		if result:
			# Add the point where the ray collides
			points_arc.push_back(to_local(result.position))
			colors.push_back(Color.RED)
		else:
			# Add the point as normal
			points_arc.push_back(_point)
			colors.push_back(Color.GREEN)
	# Update the points array
	view_cone_points = points_arc
	
	return [points_arc, colors]
