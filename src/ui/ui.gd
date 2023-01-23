extends Control

@onready var item_texture = $MarginContainer/VBoxContainer/MarginContainer3/MarginContainer/CenterContainer/HBoxContainer/MarginContainer/Item


var has_throwable = false:
	set(val):
		has_throwable = val
		item_texture.visible = has_throwable
