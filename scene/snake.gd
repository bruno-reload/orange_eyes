#*************************************************************************************************#
#                                            snake.gd                                             #
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

extends Line2D


enum pressed {ON_DRAG, OFF_DRAG}
var status = pressed.OFF_DRAG
var timeout := false
var snake_size := 0.01
export(NodePath) var grid

func _ready():
	grid = get_node(grid)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and status == pressed.OFF_DRAG:
		status = pressed.ON_DRAG
	elif event is InputEventMouseButton and !event.is_pressed():
		status = pressed.OFF_DRAG
	if event is InputEventMouseMotion and status == pressed.ON_DRAG:
			
		var current_point :Vector2 = event.position/grid.get_size()
			
		if timeout or distance_check(current_point):
			update_line(current_point)


func update_line(current_point: Vector2) -> void:
	var loop_size := 1
	while loop_size < points.size():
		var point := get_point_position(loop_size)
		set_point_position(loop_size -1,point)
		loop_size += 1
	if points.size() -1 <= 0:
		return
	set_point_position(points.size() -1,current_point)
	timeout = false

func distance_check(current_p:Vector2) -> bool:
	var last_p := get_point_position(points.size() - 1)
	if current_p.distance_to(last_p) >= snake_size:
		return true
	return false

func _on_timeout():
	timeout = true

func _punished():
	if points.size():
		remove_point(0)
	if points.size() <= 0:
		scene_load.goto_scene("res://scene/ui.tscn")


#warning-ignore:unused_argument
func _on_target_clicked(position):
	add_point(get_point_position(points.size()-1))
	
