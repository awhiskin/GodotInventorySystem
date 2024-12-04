extends Label

func _ready() -> void:
	InventorySingleton.on_inventory_updated.connect(update_inventory_value)
	update_inventory_value()

## Shows the current "value" of the inventory based on 1) quantity of an item held and 2) value of each individual item.
func update_inventory_value() -> void:
	var total_value = 0.0
	
	for crafting_material: CraftingMaterial in InventorySingleton.inventory.keys():
		var item_value = crafting_material.value
		var quantity = InventorySingleton.inventory.get(crafting_material)
		total_value += item_value * quantity

	text = "TOTAL INVENTORY VALUE $%.2f" % total_value
