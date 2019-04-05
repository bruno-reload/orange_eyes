extends Sprite

var cell_list:= Array()
export(NodePath) var grid

func _ready():
	grid = get_node(grid)
	
func _on_draw_cell(point):
	cell_list.append(point)
	update()

func _punished():
	if cell_list.size():
		cell_list.remove(0)

func _draw():
	for e in cell_list:
		var quad := Vector2(1.0,1.0)/Vector2(grid.column, grid.line)
		var pos :Vector2 = (e/grid.size) - (quad/2)
		var rect := Rect2(pos, quad)
		draw_rect(rect,Color.black)
		
		