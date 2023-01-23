extends Node2D

@onready var collider = $Area2D/CollisionShape2D
@onready var timer = $Timer
var enemies_alerted = []


func _ready():
	collider.disabled = false
	collider.shape.radius = 10
	timer.start()


#func _draw():
#	draw_circle(Vector2.ZERO, collider.shape.radius, Color(1, 1, 1, 0.5))
#
#
#func _process(_delta):
#	queue_redraw()


func _physics_process(delta):
	collider.shape.radius += 700 * delta


func _on_area_2d_body_entered(body):
	if body is BaseEnemy:
		if not body in enemies_alerted:
			enemies_alerted.append(body)


func _on_timer_timeout():
	# Disable the collision
	collider.disabled = true
	# Alert each enemy that collided with the shape
	for enemy in enemies_alerted:
		enemy.target = global_position
	# Destroy the noise emitter
	self.queue_free()

