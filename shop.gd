extends Control

var potion = Potion.new(0)

func _ready() -> void:
	%home_button.pressed.connect(_on_home_button_pressed)
	%potion_cost.text = str(potion.tier_cost[potion.tier]) + " coins"
	$coins.text = str(Global.game.player.coins)

func _on_home_button_pressed() -> void:
	SceneManager.change_scene(Enums.GameState.HOME)