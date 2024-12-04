extends Node

var inventory: Dictionary[CraftingMaterial, int]

const MAX_STACK_SIZE = 64

signal on_inventory_updated

func _ready() -> void:
	initialize_inventory()

func initialize_inventory() -> void:
	for crafting_material: CraftingMaterial in MaterialsSingleton.all_materials:
		inventory.get_or_add(crafting_material, 0)
	
	on_inventory_updated.emit()

func update_inventory_item(item: CraftingMaterial, quantity: int) -> void:
	if (quantity == 0):
		return
	elif (quantity > 0 and inventory[item] >= MAX_STACK_SIZE):
		return
	elif (quantity < 0 and inventory[item] <= 0):
		return
	else:
		inventory[item] += quantity
		inventory[item] = clampi(inventory[item], 0, 64)
	
	on_inventory_updated.emit()
