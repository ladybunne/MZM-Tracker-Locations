# MapLocation is a class that represents where a location appears on any given map.
# Locations can appear on multiple maps.
class_name MapLocation extends Resource

@export var map_name: String
@export var x: int
@export var y: int
@export var size: int
@export var border_thickness: int

func _init(p_map_name: String = map_name, p_x: int = x, p_y: int = y,
	p_size: int = 0, p_border_thickness: int = 0) -> void:
	map_name = p_map_name
	x = p_x + Globals.MAP_LOCATIONS_OFFSET_X
	y = p_y + Globals.MAP_LOCATIONS_OFFSET_Y
	size = p_size
	border_thickness = p_border_thickness

func build(p_map_name: String = map_name) -> Dictionary:
	var output = {
		"map": map_name,
		"x": x,
		"y": y
	}
	if size:
		output["size"] = size
	if border_thickness:
		output["border_thickness"] = border_thickness
	return output
