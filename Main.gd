extends Node2D

@export var maps: Dictionary

func _ready() -> void:
	# Ughhhh.
	for key in maps.keys():
		maps[key] = get_node(maps[key])
	
	var json = []
	
	# Do peeks first, actually.
	for map in maps.values():
		if map is Map:
			var peeks = map.get_peeks_to_other_areas()
			for peek in peeks:
				maps[peek.to].peeks.append(peek)
	
	# Get each map and build its locations
	for map in maps.values():
		if map is Map:
			json.append(map.build())
	
	# Write to locations.json
	var file = FileAccess.open("user://locations.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(json))
	
	# Quit!
	get_tree().quit()
