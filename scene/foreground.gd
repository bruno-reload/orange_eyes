extends Sprite

var cell_list:= Array()
export(NodePath) var vp

func _ready():
	vp = get_node(vp)

#warning-ignore:unused_argument
func _process(delta):
	material.set_shader_param("mask",(vp as Viewport).get_texture())
	update()

func _on_draw_cell(point):
	cell_list.append(point)

func _punished():
	if cell_list.size():
		cell_list.remove(0)

