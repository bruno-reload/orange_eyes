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
	if event is InputEventScreenDrag or (event is InputEventMouseMotion and status == pressed.ON_DRAG):

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

func _on_target_clicked(position):
	add_point(position/grid.size)


func _punished():
	if points.size():
		remove_point(0)
