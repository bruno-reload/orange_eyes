extends Node2D

signal draw_cell(point)
onready var grid := get_parent()

func set_point():
	$target.position = grid.real_position()
	emit_signal("draw_cell",grid.get_cell_coordinate())

#warning-ignore:unused_argument
func _on_target_clicked(position):
	var x :float = grid.get_size().x
	var y :float = grid.get_size().y
	grid.set_cell_coordinate(Vector2(rand_range(0.0,x),rand_range(0.0,y)))
	set_point()
