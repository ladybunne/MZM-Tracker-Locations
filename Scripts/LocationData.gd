# LocationData is a data class that backs Location nodes.
@tool
class_name LocationData extends Resource

# The name of the location.
@export var location_name: String :
	set(p_location_name):
		location_name = p_location_name
		location_name_changed.emit(location_name, display_name)

# Whether to prepend the map name to the location.
@export var prepend_map_name: bool = true

# An alternative display name for the location, used just for sections (not
# access rules).
@export var display_name: String :
	set(p_display_name):
		display_name = p_display_name
		location_name_changed.emit(location_name, display_name)

@export var hosted_item: String

@export var location_size: int
@export var location_border_thickness: int

signal location_name_changed(p_location_name: String, p_display_name: String)

const SECTION_NAME_FORMAT = "{map_name}{location_name}"
const ACCESS_RULE_FORMAT = "^$CanReach|{map_name}{location_name}"

# Get display name if it exists, otherwise get location name.
func get_display_name() -> String:
	return display_name if display_name else location_name

func get_section_name(p_map_name: String) -> String:
	return SECTION_NAME_FORMAT.format({
		"map_name": "%s " % p_map_name if prepend_map_name else "",
		"location_name": display_name if display_name else location_name
	})

func get_access_rule(p_map_name: String):
	return ACCESS_RULE_FORMAT.format({
		"map_name": "%s " % p_map_name if prepend_map_name else "",
		"location_name": location_name
	})
