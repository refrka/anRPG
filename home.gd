extends Control

func _ready() -> void:
	%Shop.pressed.connect(_on_shop_press)
	%Inventory.pressed.connect(_on_inventory_press)
	%BowPanel.gui_input.connect(_on_button_press.bind("bow"))
	%SpearPanel.gui_input.connect(_on_button_press.bind("spear"))
	%SwordPanel.gui_input.connect(_on_button_press.bind("sword"))
	%FightButton.pressed.connect(_on_fight_button_press)
	Global.game.player.weapon = null
	_border_off(%BowPanel)
	_border_off(%SpearPanel)
	_border_off(%SwordPanel)
	update_player_info()

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

func _on_button_press(input: InputEvent, weapon: String) -> void:
	if input.is_action_pressed("select"):
		%FightButton.disabled = false
		if weapon == "bow":
			_border_on(%BowPanel)
			_border_off(%SpearPanel)
			_border_off(%SwordPanel)
		elif weapon == "spear":
			_border_on(%SpearPanel)
			_border_off(%BowPanel)
			_border_off(%SwordPanel)
		elif weapon == "sword":
			_border_on(%SwordPanel)
			_border_off(%BowPanel)
			_border_off(%SpearPanel)
		Global.game.select_weapon(weapon)
	
func _on_fight_button_press() -> void:
	SceneManager.change_scene(Enums.GameState.COMBAT)

func _on_shop_press() -> void:
	SceneManager.change_scene(Enums.GameState.SHOP)

func _on_inventory_press() -> void:
	SceneManager.change_scene(Enums.GameState.INVENTORY)

func update_player_info() -> void:
	var player = Global.game.player
	%level.text = str(player.level)
	%hp.text = str(player.hp)
	%victories.text = str(player.victories)
	%coins.text = str(player.coins)
	if player.last_rewards != "":
		%last_rewards.text = player.last_rewards