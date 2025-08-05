extends Node2D

var player = Global.game.player
var floating_text = preload("res://floating_text.tscn")

func _ready() -> void:
	player.in_combat = true
	player.attacking.connect(_on_player_attack)
	player.hp_change.connect(_on_hp_change)
	%rat.attacking.connect(_on_rat_attack)
	%rat.died.connect(_on_rat_died)
	%hp.text = str(player.hp)
	%atk.text = str(player.get_atk())
	%def.text = str(player.get_def())
	add_child(player)
	player.position = Vector2(252, 176)

func _on_player_attack() -> void:
	if %rat:
		show_floating_text(%rat, str(-player.get_atk()))
		%rat.take_damage(player.get_atk())

func _on_rat_attack() -> void:
	show_floating_text(player, str(-%rat.get_atk()))
	player.take_damage(%rat.get_atk())

func show_floating_text(origin: Node, text: String) -> void:
	var label = floating_text.instantiate()
	add_child(label)
	label.text = text
	label.position = origin.position
	var new_y = label.position.y + 15
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(label, "position:y", new_y, 0.4)
	tween.finished.connect(label.queue_free)

func _on_hp_change() -> void:
	%hp.text = str(player.hp)

func _on_rat_died() -> void:
	player.in_combat = false
	player.gain_xp(%rat.xp_given)
	remove_child(player)
	SceneManager.end_scene(Enums.GameState.HOME)