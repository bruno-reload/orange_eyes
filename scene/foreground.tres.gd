extends Sprite

var cell_list:= Array()

func _on_draw_cell(point):
	cell_list.append(point)


func _punished():
	if cell_list.size():
		cell_list.remove(0)
