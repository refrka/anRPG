extends Node

var state: int:
	get: return state
	set(value):
		state = value
		state_update(value)

@onready var ROOT_CONTROL = $RootControl

var active_scenes:= {}

var player = preload("res://player.tscn")

func _ready() -> void:
	Global.game = self
	SceneManager.game = self
	state = 0
	player = player.instantiate()

func state_update(new_state: Enums.GameState) -> void:
	SceneManager.start_scene(new_state)

func select_weapon(weapon_type: String) -> void:
	var weapon = Weapon.new(weapon_type)
	player.weapon = weapon