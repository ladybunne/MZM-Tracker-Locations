@tool
class_name LocationData extends Resource

@export var location_name: String :
	set(p_location_name):
		location_name = p_location_name
		location_name_changed.emit(location_name)

signal location_name_changed(p_location_name: String)

const ACCESS_RULES_STRING = "^${map_name}{function_name}"

func access_rules_string(p_map_name: String):
	var regex_match = Globals.regex.search(location_name)
	var function_name = "".join(regex_match.strings.slice(1))
	return ACCESS_RULES_STRING.format({
		"map_name": p_map_name,
		"function_name": function_name
	})
