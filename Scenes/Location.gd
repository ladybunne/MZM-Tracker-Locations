# Location is a node that represents one PopTracker location.
@tool
class_name Location extends Sprite2D

@export var data: LocationData

# Need to wire this up to stuff in LocationData around not prepending map name.

const REF_STRING = "{map_name}/{map_name}/{section_name}"

func _ready() -> void:
	data.location_name_changed.connect(func(p_location_name, p_display_name):
		name = data.get_display_name() if data.get_display_name() else "Location")
	scale = Vector2(8, 8) / texture.get_size()

func get_map_location(p_map_name: String) -> Dictionary:
	var map_location = MapLocation.new(p_map_name, position.x, position.y,
		data.location_size, data.location_border_thickness)
	return map_location.build()

func get_map_location_combined_map(p_x: int, p_y: int) -> Dictionary:
	var map_location = MapLocation.new("Combined", position.x + p_x, position.y + p_y,
		data.location_size, data.location_border_thickness)
	return map_location.build()

func build_child(p_map_name: String, p_x: int, p_y: int) -> Dictionary:
	var output = {
		"name": data.get_section_name(p_map_name),
		"sections": [build_ref_section(p_map_name)],
		"map_locations": [get_map_location(p_map_name), get_map_location_combined_map(p_x, p_y)]
	}
	
	return output

func build_base_section(p_map_name: String, p_unopened_img: String) -> Dictionary:
	var output = {
		"name": data.get_section_name(p_map_name),
		"access_rules": data.get_access_rule(p_map_name)
	}
	if data.hosted_item:
		output["hosted_item"] = data.hosted_item
	if p_unopened_img:
		output["chest_unopened_img"] = "images/%s" % p_unopened_img
	return output

func build_ref_section(p_map_name: String) -> Dictionary:
	return {
		"name": " ",
		"ref": REF_STRING.format({
			"map_name": p_map_name,
			"section_name": data.get_section_name(p_map_name)
		})
	}
