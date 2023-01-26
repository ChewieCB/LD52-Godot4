extends StaticBody2D
class_name Gate

@export var player: Player
@export var key: Node2D

@onready var label = $Label
@onready var sprite = $Sprite2D
@onready var collider = $CollisionShape2D
@onready var area_collider = $Area2D/CollisionShape2D

var can_unlock = false


func _input(event):
	if event.is_action_released("interact"):
		if can_unlock:
			sprite.visible = false
			collider.disabled = true
			area_collider.disabled = true
			player.keys.erase(key)


func _on_area_2d_body_entered(body):
	if body is Player:
		if key in body.keys:
			label.text = "E to unlock"
			can_unlock = true
		else:
			label.text = "Needs a key"
			can_unlock = false
		label.visible = true


func _on_area_2d_body_exited(body):
	if body is Player:
		label.visible = false
		can_unlock = false

