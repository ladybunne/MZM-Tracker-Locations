@tool
class_name Location extends Sprite2D

@export var data: LocationData

func _ready() -> void:
	data.location_name_changed.connect(func(p_location_name): name = p_location_name if p_location_name else "Location")
