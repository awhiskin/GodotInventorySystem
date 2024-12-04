extends Node

var all_materials: Array[CraftingMaterial]:
	get:
		return load_resources()

func load_resources() -> Array[CraftingMaterial]:
	var materials: Array[CraftingMaterial]
	
	for file_name in DirAccess.get_files_at("res://resources/crafting_materials"):
		materials.append(load("res://resources/crafting_materials/"+file_name))
	
	return materials
