class_name CraftingMaterial
extends Resource

@export var is_harvestable: bool = true
@export var value: float = 1.0
@export var inventory_icon: Texture2D

var name: String:
	get:
		return self.resource_path.get_file().split(".")[0].to_upper()
