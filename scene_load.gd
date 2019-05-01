extends Node

var loader
var time_max = 100 # msec
var current_scene
var sound = AudioStreamPlayer.new()

func _ready():
	sound.set_stream(load("res://resources/open/orange.wav"))
	sound.set_volume_db(-25)
	get_node("/root").call_deferred("add_child",sound)
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	goto_scene("res://scene/ui.tscn")

func goto_scene(path): # game requests to switch to this scene
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		print("null scene in scene_load script")
		return
		
	current_scene.queue_free() 
	
	set_process(true)

func _process(time):
	if loader == null:
		set_process(false)
		return

	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: 
	
		var err = loader.poll()

		if err == ERR_FILE_EOF: 
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		if err != OK and err != ERR_FILE_EOF: 
			print("error loading feature to scene")
			loader = null
			break


func set_new_scene(scene_resource):
	print(scene_resource._get_bundled_scene().values()[0][0])
	if str(scene_resource._get_bundled_scene().values()[0][0]) == "game":
		sound.stop()
	if str(scene_resource._get_bundled_scene().values()[0][0]) != "game":
		if not sound.is_playing():
			sound._set_playing(true)
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)