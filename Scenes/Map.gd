# Map is a node that represents a whole PopTracker map.
@tool
class_name Map extends Sprite2D

@export var data: MapData

var peeks: Array[MapPeek]

func _ready() -> void:
	data.map_name_changed.connect(func(p_map_name): name = p_map_name if p_map_name else "Map")

# Get the child member that represents the entire area, and has all of the locations within.
# This is used for peeks.
func get_area_child() -> Dictionary:
	var sections = []
	for child in get_children():
		if child is Location:
			var unopened_img = Globals.get_image_name(child.texture)
			var built_child = child.build_base_section(data.map_name, unopened_img if unopened_img != "MissileTank.png" else "")
			
			# Don't add locations if they already exist in the list.
			var existing = sections.filter(func(p: Dictionary): return p["name"] == built_child["name"])
			if not existing:
				sections.append(built_child)
	return {
		"name": data.map_name,
		"sections": sections,
		"map_locations": peeks.map(func(peek: MapPeek): return peek.get_map_location().build())
	}

func get_peeks_to_other_areas() -> Array[MapPeek]:
	var output = [] as Array[MapPeek]
	for child in get_children():
		if child is MapPeek:
			child.from = data.map_name
			output.append(child)
	return output

func get_child_locations() -> Array[Dictionary]:
	var children_json = [] as Array[Dictionary]
	for child in get_children():
		if child is Location:
			var built_child = child.build_child(data.map_name, position.x, position.y)
			
			# Merge multiple copies of the same location into one section with multiple map locations.
			var existing = children_json.filter(func(p: Dictionary): return p["name"] == built_child["name"])
			if existing:
				existing.front()["map_locations"].append_array(built_child["map_locations"])
			else:
				children_json.append(built_child)
	return children_json

func build() -> Dictionary:
	var children = get_child_locations()
	children.insert(0, get_area_child())
	
	return {
		"name": data.map_name,
		"chest_unopened_img": "images/%s" % Globals.get_image_name(data.unopened_img as CompressedTexture2D),
		"chest_opened_img": "images/%s" % Globals.get_image_name(data.opened_img as CompressedTexture2D),
		"children": children
	}
