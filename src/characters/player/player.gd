class_name Player
extends BaseCharacter

@onready @export var tilemap: TileMap
@onready var ui = $UILayer/UI
@onready var crosshair = $Aim

var bottle = preload("res://src/throwables/Bottle.tscn")

var is_torch_enabled = true:
	set(val):
		is_torch_enabled = val
		$ViewLight.visible = is_torch_enabled

var has_throwable = false:
	set(val):
		has_throwable = val
		crosshair.visible = has_throwable
		ui.has_throwable = has_throwable
		$Sprite/Bottle.visible = has_throwable


#func _ready():
#	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if has_throwable:
				# Spawn a bottle
				var bottle_instance = bottle.instantiate()
				bottle_instance.global_position = global_position
				bottle_instance.target = crosshair.global_position
				get_parent().add_child(bottle_instance)
				has_throwable = false

func _physics_process(delta: float) -> void:
	# Debug reset/quit inputs
	if Input.is_action_pressed("reset"):
		var _ret = get_tree().reload_current_scene()
	elif Input.is_action_pressed("quit"):
		get_tree().quit()
	
	crosshair.global_position = get_global_mouse_position()
	
	states.physics_process(delta)
	
	# TODO - find a better way to check this
	if not is_dead:
		var current_cell = tilemap.local_to_map(position)
		var cell_data = tilemap.get_cell_tile_data(0, current_cell)
		if cell_data and cell_data.get_custom_data("is_crop"):
			is_torch_enabled = false
			move_modifier = 0.80
			$PlayerLight.texture_scale = 0.45
		else:
			is_torch_enabled = true
			move_modifier = 1.0
			$PlayerLight.texture_scale = 0.75
