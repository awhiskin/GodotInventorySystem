extends Button

@onready var inventory_buttons: InventoryButtons = $"../Inventory Buttons"

func _ready() -> void:
	if (!inventory_buttons):
		return
	
	self.pressed.connect(inventory_buttons.initialize_inventory_buttons)
