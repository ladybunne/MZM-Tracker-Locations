@tool
class_name MapData extends Resource

@export var map_name: String :
	set(p_map_name):
		map_name = p_map_name
		map_name_changed.emit(map_name)
@export var unopened_img: Texture2D
@export var opened_img: Texture2D

signal map_name_changed(p_map_name: String)
