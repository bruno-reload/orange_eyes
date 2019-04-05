extends Node2D

signal draw_cell(point)
onready var grid := get_parent()
var last_position :Vector2
	
func set_point():
	$target.position = grid.real_position()
	emit_signal("draw_cell",last_position)

func _on_target_clicked(position):
	last_position = position
	var x :float = grid.get_size().x
	var y :float = grid.get_size().y
	grid.set_cell_coordinate(Vector2(rand_range(0.0,x),rand_range(0.0,y)))
	set_point()

