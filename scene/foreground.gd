#*************************************************************************************************#
#                                        foreground.gd                                            #
#                                                                                                 #
#*************************************************************************************************#
#                                    This file is part of:                                        #
#                                         orange eyes                                             #
#*************************************************************************************************#
#*************************************************************************************************#
#                            Copyright 2019 Bruno Correia da Silva                                #
#                                                                                                 #
#Permission is hereby granted, free of charge, to any person obtaining a copy of this     software#
#and associated documentation files (the "Software"), to deal in the Software without restriction,#
#including without limitation the rights to use, copy, modify, merge, publish,         distribute,#
#sublicense, and/or sell copies of the Software, and to permit persons to whom     the Software is#
# furnished to do so, subject to the following conditions:                                        #
#                                                                                                 #
#The above copyright notice and this permission notice shall be included in all copies          or#
#substantial portions of the Software.                                                            #
#                                                                                                 #
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR               IMPLIED,#
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A         PARTICULAR#
#PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE     LIABLE FOR#
#ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR       OTHERWISE,#
#ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN       THE#
#SOFTWARE.                                                                                        #
#*************************************************************************************************#

extends Sprite

var cell_list:= Array()
export(NodePath) var grid
var map 
var end = true

func _ready():
	grid = get_node(grid)
	
func _on_draw_cell(point):
	if not cell_list.has(point):
		cell_list.append(point)
	quad_count()
	
func _process(delta):
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
		

func quad_count():
	if cell_list.size() >= grid.column * grid.line:
		if end:
			scene_load.goto_scene("res://scene/blind_balloons.tscn")
			end = false
	pass