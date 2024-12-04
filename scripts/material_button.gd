class_name MaterialButton
extends Button

# 
@export var crafting_material: CraftingMaterial

var is_random: bool = false

func _ready() -> void:
	self.pressed.connect(add_some_materials)
	
	if (!crafting_material):
		is_random = true
		crafting_material = MaterialsSingleton.all_materials.pick_random()
		
	
	if (!is_random):
		self.text = "ADD " + crafting_material.name
	else:
		self.text = "(RANDOM) ADD " + crafting_material.name

	icon = crafting_material.inventory_icon

func add_some_materials(amount: int = 1):
	var add_amount = amount
	if (is_random):
		add_amount = randi_range(1, 10)
	InventorySingleton.update_inventory_item(crafting_material, add_amount)
