extends GridContainer

@export var tile_scene: PackedScene

func _ready() -> void:
	InventorySingleton.on_inventory_updated.connect(refresh_inventory)
	refresh_inventory()

func refresh_inventory() -> void:
	for child: Node in get_children(true):
		child.queue_free()
	
	for crafting_material: CraftingMaterial in InventorySingleton.inventory.keys():
		var new_tile = tile_scene.instantiate()
		
		var texture_rect: TextureRect = new_tile.get_node_or_null("./VBoxContainer/MarginContainer/TextureRect")
		texture_rect.texture = crafting_material.inventory_icon
		
		var label: Label = new_tile.get_node_or_null("./VBoxContainer/Label")
		label.text = "%s: %d" % [crafting_material.name, InventorySingleton.inventory[crafting_material]]
		
		add_child(new_tile)
