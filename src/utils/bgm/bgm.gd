extends Node2D

@onready var audio_player = $AudioStreamPlayer

@export var music_tracks: Array[AudioStreamMP3]
var previous_track


func _ready():
	play_new_track()
	
	
func play_new_track():
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	var new_tracks = music_tracks
	if previous_track:
		new_tracks.erase(previous_track)
		
	var track_index = random.randi_range(0, new_tracks.size() - 1)
	var new_track = new_tracks[track_index]
	audio_player.stream = new_track
	audio_player.play()


func _on_audio_stream_player_finished():
	play_new_track()
