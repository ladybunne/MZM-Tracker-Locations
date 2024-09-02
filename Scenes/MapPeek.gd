class_name MapPeek extends Sprite2D

@export var to: String
var from: String

func get_map_location() -> MapLocation:
	return MapLocation.new(from, position.x, position.y)
