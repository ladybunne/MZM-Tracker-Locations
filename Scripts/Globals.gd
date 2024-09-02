extends Node

var regex = RegEx.new()
var ACCESS_RULES_REGEX = "(\\w*)[^\\w\"]*(\\w*)[^\\w\"]*(\\w*)[^\\w\"]*(\\w*)[^\\w\"]*(\\w*)[^\\w\"]*(\\w*)[^\\w\"]*(\\w*)[^\\w\"]*(\\w*)[^\\w\"]*"

const MAP_LOCATIONS_OFFSET_X = 4
const MAP_LOCATIONS_OFFSET_Y = 4

func _ready() -> void:
	regex.compile(ACCESS_RULES_REGEX)

func get_image_name(p_img: CompressedTexture2D) -> String:
	return p_img.resource_path.split("/")[-1]
