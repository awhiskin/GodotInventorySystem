extends Button

func _ready() -> void:
	self.pressed.connect(InventorySingleton.clear_inventory)
