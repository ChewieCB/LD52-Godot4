extends Node2D
class_name Throwable

@export @onready var player: Player
@onready var popup = $Label

var can_pick_up = false
@export var infinite: bool = false


func _input(event):
	if event.is_action_released("interact"):
		if can_pick_up and not player.has_throwable:
			player.has_throwable = true
			if not infinite:
				self.queue_free()


func _on_area_2d_body_entered(body):
	if body is Player:
		popup.visible = true
		can_pick_up = true


func _on_area_2d_body_exited(body):
	if body is Player:
		popup.visible = false
		can_pick_up = false
