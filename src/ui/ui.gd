extends Control

@onready var throwable_texture = $MarginContainer/VBoxContainer/MarginContainer3/MarginContainer/CenterContainer/HBoxContainer/Throwable/Item
@onready var key_texture = $MarginContainer/VBoxContainer/MarginContainer3/MarginContainer/CenterContainer/HBoxContainer/Key/Item


var has_throwable = false:
	set(val):
		has_throwable = val
		throwable_texture.visible = has_throwable


var has_key = false:
	set(val):
		has_key = val
		key_texture.visible = has_key
