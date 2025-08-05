extends Node2D

signal attacking
signal died

var can_attack:= true
var hp:= 15
var atk:= 2
var def:= 1
var atk_time:= 1.5
var timer:= 0.0
var xp_given: int:
	get: return randi_range(4,6)

func attack() -> void:
	attacking.emit()

func die() -> void:
	visible = false
	can_attack = false
	var _timer = Global.game.get_tree().create_timer(0.5)
	_timer.timeout.connect(func():
		SceneManager.change_scene(Enums.GameState.HOME))
	died.emit()

func take_damage(amt: int) -> void:
	hp -= amt
	if hp <= 0:
		die()

func get_atk() -> int:
	return atk

func _process(delta: float) -> void:
	if can_attack == true:
		if timer <= atk_time:
			timer += delta
		else:
			attack()
			timer = 0.0
