class_name InventoryButtons
extends VBoxContainer

# Reference to the "button" scene we want to instantiate
@export var button: PackedScene

func _ready():
	initialize_inventory_buttons()

## This function initializes a series of buttons that will add items to the inventory.
func initialize_inventory_buttons() -> void:
	# Return if we don't have a reference to a button scene.
	if (!button):
		return
	
	# Clear all children.
	for child: Node in get_children(true):
		child.queue_free()
	
	# Add a button, without giving it a CraftingMaterial type
	# Without a pre-defined type, it automatically picks one at random. See the material_button.gd script.
	var random_button: MaterialButton = button.instantiate()
	add_child(random_button)
	
	# Visual seperator
	var seperator: HSeparator = HSeparator.new()
	seperator.add_theme_constant_override("separation", 32)
	add_child(seperator)
	
	# For each crafting material, create a button.
	# These buttons represent actions in-game that would award or take away a certain quantity of a crafting material from the inventory.
	for crafting_material: CraftingMaterial in InventorySingleton.inventory.keys():
		var new_button: MaterialButton = button.instantiate()
		
		new_button.crafting_material = crafting_material
		
		# If the crafting material isn't "harvestable", disable the GUI button.
		new_button.disabled = !crafting_material.is_harvestable
		new_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND if crafting_material.is_harvestable else Control.CURSOR_FORBIDDEN
		
		add_child(new_button)
