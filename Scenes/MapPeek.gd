# MapPeek is a special node that represents a "map peek" - a PopTracker section 
# that lets you "peek" at an adjacent zone to see the status of its checks.
class_name MapPeek extends Sprite2D

@export var to: String
var from: String

func get_map_location() -> MapLocation:
	return MapLocation.new(from, position.x, position.y)
