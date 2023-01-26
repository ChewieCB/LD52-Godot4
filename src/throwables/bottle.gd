extends CharacterBody2D

var target: Vector2
var origin_point: Vector2
var dir_to_target: Vector2
var move_speed = 150
var max_speed = 400
var max_distance = 250
var distance_moved = 0

var noise = preload("res://src/throwables/NoiseEmitter.tscn")

var can_move = true:
	set(val):
		can_move = val
		if not can_move:
			shatter()

@export var glass_sfx: Array[AudioStreamMP3]
var previous_sfx

@onready var audio_player = $AudioStreamPlayer2D


func _ready():
	origin_point = global_position
	if target:
		dir_to_target = global_position.direction_to(target)


func _physics_process(delta):
	if can_move:
		if global_position != target and abs(distance_moved) < max_distance:
			velocity += dir_to_target * move_speed
			velocity = velocity.limit_length(max_speed)
			distance_moved = global_position.distance_to(origin_point)
			move_and_slide()
			rotation_degrees += 10
			if get_slide_collision_count() != 0:
				can_move = false
		else:
			can_move = false


func shatter():
	# Spawn a noise emitter
	var noise_instance = noise.instantiate()
	noise_instance.global_position = global_position
	get_parent().add_child(noise_instance)
	$Sprite2D.visible = false
	#
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	var usable_sfx = glass_sfx
	if previous_sfx:
		usable_sfx.erase(previous_sfx)
		
	var sfx_index = random.randi_range(0, usable_sfx.size() - 1)
	var shatter_sfx = usable_sfx[sfx_index]
	audio_player.stream = shatter_sfx
	audio_player.play()
#
	await audio_player.finished
	queue_free()

