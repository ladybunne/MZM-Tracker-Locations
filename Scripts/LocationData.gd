@tool
class_name LocationData extends Resource

@export var location_name: String :
	set(p_location_name):
		location_name = p_location_name
		location_name_changed.emit(location_name)

signal location_name_changed(p_location_name: String)

const ACCESS_RULES_STRING = "^$CanReach|{map_name} {location_name}"

func access_rules_string(p_map_name: String):
	return ACCESS_RULES_STRING.format({
		"map_name": p_map_name,
		"location_name": location_name
	})
