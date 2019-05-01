extends Node

signal cell_coordinate_select(coordinate)# estilo errado usar preterito

onready var size:= get_viewport().get_visible_rect().size setget set_size, get_size

var coordinate := Vector2() setget set_cell_coordinate, get_cell_coordinate

export(int,1,12) var line  := 1
export(int,1,16) var column:= 1

onready var delta_size:= size/Vector2(line,column) setget ,get_delta_size

var proportion: = Vector2() 

#warning-ignore:unused_argument
func _process(delta):
	set_size(get_viewport().get_visible_rect().size)

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
			
		set_cell_coordinate(event.position)

func get_delta_size():
	return delta_size

func set_size(grid_size: Vector2 ) -> void:
	size = grid_size

func get_size() -> Vector2:
	return size
       
func get_cell_coordinate() -> Vector2:
	return coordinate

func set_cell_coordinate(coor: Vector2) -> void:
	
	proportion.x = coor.x/size.x                              
	proportion.y = coor.y/size.y                             
	                                                         
	coordinate.x = int(proportion.x/(1.0/column)) + 1        
	coordinate.y = int(proportion.y/(1.0/line)) + 1 
	
	emit_signal("cell_coordinate_select",coordinate) 

func real_position(c :Vector2 = self.coordinate, size := Vector2(1024,600)) -> Vector2:
	var fraction := Vector2(size.x/column,size.y/line)
	var coord:= fraction*c
	coord = coord - (fraction/2.0)
	return coord

