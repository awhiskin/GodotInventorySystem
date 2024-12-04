extends GridContainer

# Reference to the "tile" scene we want to instantiate
@export var tile_scene: PackedScene
@export var hide_empty_items: bool = true

func _ready() -> void:
	InventorySingleton.on_inventory_updated.connect(refresh_inventory)
	refresh_inventory()

## This function initializes a series of "tiles" that show the current number of items held in the inventory.
func refresh_inventory() -> void:
	# Return if we don't have a reference to a tile scene.
	if (!tile_scene):
		return
	
	# Clear all children.
	for child: Node in get_children(true):
		child.queue_free()
	
	# Get all items held in the inventory, and add a tile to visually represent it.
	for crafting_material: CraftingMaterial in InventorySingleton.inventory.keys():		
		var new_tile: Control = tile_scene.instantiate()
		
		# Show the crafting material's icon
		var texture_rect: TextureRect = new_tile.get_node_or_null("./VBoxContainer/MarginContainer/TextureRect")
		texture_rect.texture = crafting_material.inventory_icon
		
		# Update label to have the crafting material name and current quantity
		var label: Label = new_tile.get_node_or_null("./VBoxContainer/Label")
		label.text = "%s: %d" % [crafting_material.name, InventorySingleton.inventory[crafting_material]]
		
		# Partially hide items that have 0 quantity
		if (hide_empty_items and InventorySingleton.inventory[crafting_material] <= 0):
			new_tile.modulate.a = 0.5
		
		add_child(new_tile)
