extends Node

const MAP_LOCATIONS_OFFSET_X = 4
const MAP_LOCATIONS_OFFSET_Y = 4

func get_image_name(p_img: CompressedTexture2D) -> String:
	return p_img.resource_path.split("/")[-1]
