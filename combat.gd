extends Node2D

var player = Global.game.player
var floating_text = preload("res://floating_text.tscn")
var enemy_list = [
	Enums.Enemies.RAT,
	Enums.Enemies.BAT,
]
var enemy: Node

func _ready() -> void:
	var enemy_id = enemy_list.pick_random()
	enemy = Enemy.new(enemy_id)
	add_child(enemy.node)
	enemy.node.position = Vector2(376, 184)
	player.in_combat = true
	player.attacking.connect(_on_player_attack)
	player.hp_change.connect(_on_hp_change)
	enemy.attacking.connect(_on_enemy_attack)
	enemy.died.connect(_on_enemy_died)
	%hp.text = str(player.hp)
	%atk.text = str(player.get_atk())
	%def.text = str(player.get_def())
	add_child(player)
	player.position = Vector2(252, 176)

func _on_player_attack() -> void:
	if enemy:
		show_floating_text(enemy, str(-player.get_atk()))
		enemy.take_damage(player.get_atk())

func _on_enemy_attack() -> void:
	show_floating_text(player, str(-enemy.get_atk()))
	player.take_damage(enemy.get_atk())

func show_floating_text(origin: Node, text: String) -> void:
	var label = floating_text.instantiate()
	add_child(label)
	label.text = text
	if origin is Enemy:
		label.position = origin.node.position
	else:
		label.position = origin.position
	var new_y = label.position.y + 15
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(label, "position:y", new_y, 0.4)
	tween.finished.connect(label.queue_free)

func _on_hp_change() -> void:
	%hp.text = str(player.hp)

func _on_enemy_died() -> void:
	enemy.attacking.disconnect(_on_enemy_attack)
	enemy.died.disconnect(_on_enemy_died)
	player.in_combat = false
	player.gain_combat_rewards(enemy)
	remove_child(player)
	SceneManager.end_scene(Enums.GameState.HOME)

func _process(delta: float) -> void:
	if enemy.can_attack == true:
		if enemy.timer <= enemy.atk_time:
			enemy.timer += delta
		else:
			enemy.attack()
			enemy.timer = 0.0