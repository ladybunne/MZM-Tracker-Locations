@tool
class_name Map extends Sprite2D

@export var data: MapData

func _ready() -> void:
	data.map_name_changed.connect(func(p_map_name): name = p_map_name if p_map_name else "Map")
