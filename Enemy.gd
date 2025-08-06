class_name Enemy extends Node

signal attacking
signal died

var data_ref = {
    Enums.Enemies.RAT: "res://enemies/rat.tres",
    Enums.Enemies.BAT: "res://enemies/bat.tres"
}
var data: EnemyData
var node: Node

func _init(id: Enums.Enemies) -> void:
    data = load(data_ref[id])
    node = data.enemy_scene.instantiate()

    can_attack = data.can_attack
    hp = data.hp
    atk = data.atk
    def = data.def
    atk_time = data.atk_time
    xp_value = data.xp_value
    coin_value = randi_range(data.coin_value_min, data.coin_value_max)
    loot = data.loot
    loot_chance = data.loot_chance

var can_attack: bool
var hp: int
var atk: int
var def: int
var atk_time: float
var timer:= 0.0
var xp_value: int
var coin_value: int
var loot: Array[Enums.Items]
var loot_chance = 10

func attack() -> void:
    attacking.emit()

func die() -> void:
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