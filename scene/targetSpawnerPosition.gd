extends Node2D

signal draw_cell(point)
onready var grid := get_parent()
var last_position :Vector2

func _ready():
	randomize()
	
	
func set_spawner_target():
	$target.position = grid.real_position()
	$target/audio.set_volume_db($target.vol[grid.get_cell_coordinate().y - 1])
	$target/audio.set_stream($target.sounds[grid.get_cell_coordinate().x - 1])
	emit_signal("draw_cell",last_position)

func _on_target_clicked(position):
	last_position = position
	var x :float = grid.get_size().x
	var y :float = grid.get_size().y
	grid.set_cell_coordinate(Vector2(rand_range(0,x),rand_range(0,y)))
	set_spawner_target()

