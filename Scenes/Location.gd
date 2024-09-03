@tool
class_name Location extends Sprite2D

@export var data: LocationData

const NAME_WITH_LOCATION = "{map_name} {location_name}"
const REF_STRING = "{map_name}/{map_name}/" + NAME_WITH_LOCATION

func _ready() -> void:
	data.location_name_changed.connect(func(p_location_name): name = p_location_name if p_location_name else "Location")

func get_map_location(p_map_name: String) -> Dictionary:
	var map_location = MapLocation.new(p_map_name, position.x, position.y)
	return map_location.build()

func get_map_location_combined_map(p_x: int, p_y: int) -> Dictionary:
	var map_location = MapLocation.new("Combined", position.x + p_x, position.y + p_y)
	return map_location.build()

func build_child(p_map_name: String, p_x: int, p_y: int) -> Dictionary:
	var output = {
		"name": NAME_WITH_LOCATION.format({
			"map_name": p_map_name,
			"location_name": data.location_name
		}),
		"sections": [build_ref_section(p_map_name)],
		"map_locations": [get_map_location(p_map_name), get_map_location_combined_map(p_x, p_y)]
	}
	
	return output

func build_base_section(p_map_name: String, p_unopened_img: String) -> Dictionary:
	var output = {
		"name": NAME_WITH_LOCATION.format({
			"map_name": p_map_name,
			"location_name": data.location_name
		}),
		"access_rules": data.access_rules_string(p_map_name)
	}
	if p_unopened_img:
		output["chest_unopened_img"] = "images/%s" % p_unopened_img
	return output

func build_ref_section(p_map_name: String) -> Dictionary:
	return {
		"name": " ",
		"ref": REF_STRING.format({
			"map_name": p_map_name,
			"location_name": data.location_name
		})
	}
