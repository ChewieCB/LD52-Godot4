class_name Player
extends BaseCharacter

@onready @export var tilemap: TileMap
@export var walk_sfx: AudioStreamMP3
@export var walk_crop_sfx: AudioStreamMP3

@onready var ui = $UILayer/UI
@onready var crosshair = $Aim
@onready var blood = $BloodSplatter
@onready var audio_player = $AudioStreamPlayer2D

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

# Array of key names
var keys = []


#func _ready():
#	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if has_throwable and states.current_state != $StateManager/DeathState:
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
	
	print(audio_player.stream)
	print(audio_player.is_playing())
	
	states.physics_process(delta)
	
	# TODO - find a better way to check this
	if not is_dead:
		var current_cell = tilemap.local_to_map(position)
		if current_cell:
			var cell_data = tilemap.get_cell_tile_data(0, current_cell)
			if cell_data and cell_data.get_custom_data("is_crop"):
				is_torch_enabled = false
				move_modifier = 0.70
				$PlayerLight.texture_scale = 0.2
				change_walk_sfx(walk_crop_sfx)
			else:
				is_torch_enabled = true
				move_modifier = 1.0
				$PlayerLight.texture_scale = 0.25
				change_walk_sfx(walk_sfx)
	
	if keys.size() > 0:
		ui.has_key = true
	else:
		ui.has_key = false


func change_walk_sfx(sfx):
	if audio_player.stream == sfx:
		return
	if audio_player.is_playing():
		audio_player.stop()
	audio_player.stream = sfx
	audio_player.play()
	
	

