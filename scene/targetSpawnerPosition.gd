#*************************************************************************************************#
#                                  targetSpawnerPosition.gd                                       #
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

