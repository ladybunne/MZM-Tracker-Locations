# Dumb thing for dumb reasons.
class_name MapLocation extends Resource

@export var map_name: String
@export var x: int
@export var y: int

func _init(p_map_name: String = map_name, p_x: int = x, p_y: int = y) -> void:
	map_name = p_map_name
	x = p_x + Globals.MAP_LOCATIONS_OFFSET_X
	y = p_y + Globals.MAP_LOCATIONS_OFFSET_Y

func build(p_map_name: String = map_name) -> Dictionary:
	return {
		"map": map_name,
		"x": x,
		"y": y
	}
