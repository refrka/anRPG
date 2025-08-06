extends Control

var item_panels = []
var selected_item: Node

func _ready() -> void:
	%home_button.pressed.connect(_on_home_button_pressed)
	var item_count = 0
	for item in Global.game.player.inventory:
		var item_panel = %item_list.get_child(item_count)
		item_panels.append(item_panel)
		item_panel.gui_input.connect(_on_gui_input.bind(item_panel))
		var item_sprite = item_panel.get_child(0)
		item_sprite.texture = item.texture
		for label in %item_labels.get_children():
			if label.name == "ItemLabel%s" % item_count:
				label.text = item.item_name
		item_count += 1
	if item_count == Global.game.player.max_inventory_size:
		%inventory_full.visible = true

func _border_on(panel: PanelContainer) -> void:
	var stylebox = panel.get_theme_stylebox("panel")
	stylebox.border_width_left = 1
	stylebox.border_width_top = 1
	stylebox.border_width_right = 1
	stylebox.border_width_bottom = 1
	panel.add_theme_stylebox_override("panel", stylebox)

func _border_off(panel: PanelContainer) -> void:
	var stylebox = panel.get_theme_stylebox("panel")
	stylebox.border_width_left = 0
	stylebox.border_width_top = 0
	stylebox.border_width_right = 0
	stylebox.border_width_bottom = 0
	panel.add_theme_stylebox_override("panel", stylebox)

func _on_home_button_pressed() -> void:
	SceneManager.end_scene(Enums.GameState.HOME)

func _on_gui_input(input: InputEvent, selected_panel: PanelContainer) -> void:
	if input.is_action_pressed("select"):
		for panel in item_panels:
			if selected_panel == panel:
				%use.pressed.connect(_on_use.bind(panel))
				%discard.pressed.connect(_on_discard.bind(panel))
				_border_on(panel)
				var index = item_panels.find(panel)
				selected_item = Global.game.player.inventory[index]
				_toggle_buttons()
			else:
				_border_off(panel)

func _toggle_buttons() -> void:
	%use.disabled = not %use.disabled
	%discard.disabled = not %discard.disabled

func _on_use(panel: PanelContainer) -> void:
	selected_item.use()
	panel.gui_input.disconnect(_on_gui_input)
	if Global.game.player.inventory.has(selected_item):
		Global.game.player.inventory.erase(selected_item)
	selected_item = null
	_border_off(panel)
	_toggle_buttons()

func _on_discard(panel: PanelContainer) -> void:
	panel.gui_input.disconnect(_on_gui_input)
	if Global.game.player.inventory.has(selected_item):
		Global.game.player.inventory.erase(selected_item)
	selected_item = null
	_border_off(panel)
	_toggle_buttons()

		