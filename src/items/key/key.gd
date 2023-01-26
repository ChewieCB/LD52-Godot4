extends Node2D
class_name Key

@export @onready var player: Player
@onready var popup = $Label
@onready var sprite = $Sprite2D
@onready var collider = $Area2D/CollisionShape2D

var can_pick_up = false


func _input(event):
	if event.is_action_released("interact"):
		if can_pick_up:
			player.keys.append(self)
			sprite.visible = false
			collider.disabled = true


func _on_area_2d_body_entered(body):
	if body is Player:
		popup.visible = true
		can_pick_up = true


func _on_area_2d_body_exited(body):
	if body is Player:
		popup.visible = false
		can_pick_up = false
