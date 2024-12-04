extends Node

## The inventory at its simplest [CraftingMaterial, quantity]
# Do note typed dicionaries are only available in Godot 4.4 dev 2 and above.
# Simply remove the typing for compatibility with other versions of Godot 4.X

# var inventory: Dictionary

var inventory: Dictionary[CraftingMaterial, int]

# Arbitrary; but allows you to limit the max number of a particular CraftingMaterial
const MAX_STACK_SIZE = 64

# Signal that is emitted whenever the inventory is updated.
# Informs the GUI labels etc. that the inventory must be refreshed.
signal on_inventory_updated

func _ready() -> void:
	initialize_inventory()

# For every possible CraftingMaterial found in the singleton, add to the inventory with an initial value of 0.
func initialize_inventory() -> void:
	for crafting_material: CraftingMaterial in MaterialsSingleton.all_materials:
		inventory.get_or_add(crafting_material, 0)
	
	on_inventory_updated.emit()

# Quantity is assumed to be a value to either add or subtract from the existing value.
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

# Set all quantity values to 0
func clear_inventory() -> void:
	for item in inventory:
		inventory[item] = 0
	
	on_inventory_updated.emit()
