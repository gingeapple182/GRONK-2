extends Node

# AudioManager.gd
# This autoload handles global sound effect and music playback.
# Use this to play SFX or music from anywhere in your game.
# Prevents overlapping or spamming of the same sound.

# Example usage:
#	AudioManager.play_sfx("res://audio/coin.wav")
#	AudioManager.play_music("res://audio/music_theme.ogg")

var music_player: AudioStreamPlayer = null
var sfx_players: Array = []

func _ready():
	# Create a dedicated music player
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	# Optionally, preload a pool of SFX players
	for i in range(8):
		var sfx = AudioStreamPlayer.new()
		add_child(sfx)
		sfx_players.append(sfx)

func play_sfx(path: String):
	# Plays a sound effect from the given path
	for sfx in sfx_players:
		if not sfx.playing:
			sfx.stream = load(path)
			sfx.play()
			return
	# If all players are busy, play on the first one (fallback)
	sfx_players[0].stream = load(path)
	sfx_players[0].play()

func play_music(path: String):
	# Plays music, stopping any previous track
	if music_player.playing:
		music_player.stop()
	music_player.stream = load(path)
	music_player.play()
