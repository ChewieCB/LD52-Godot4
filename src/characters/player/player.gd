class_name Player
extends BaseCharacter

@onready @export var tilemap: TileMap

var is_torch_enabled = true:
	set(val):
		is_torch_enabled = val
		$ViewCone.visible = is_torch_enabled


func _physics_process(delta: float) -> void:
	# Debug reset/quit inputs
	if Input.is_action_pressed("reset"):
		var _ret = get_tree().reload_current_scene()
	elif Input.is_action_pressed("quit"):
		get_tree().quit()
	
	states.physics_process(delta)
	
	# TODO - find a better way to check this
	var current_cell = tilemap.local_to_map(self.position)
	var cell_data = tilemap.get_cell_tile_data(0, current_cell)
	if cell_data.get_custom_data("is_crop"):
		is_torch_enabled = false
		move_modifier = 0.80
		$PlayerLight.texture_scale = 0.35
	else:
		is_torch_enabled = true
		move_modifier = 1.0
		$PlayerLight.texture_scale = 0.75
