extends Node2D

signal attacking
signal hp_change

var weapon: Weapon

var in_combat:= true
var level:= 1
var xp:= 0:
    set(value):
        if value != 0:
            xp += value
            if xp >= Global.level_xp[level]:
                level_up()
        else:
            xp = value
var hp:= 25
var atk:= 1
var def:= 1
var atk_time:= 0.2
var timer:= 0.0

func level_up() -> void:
    print("you leveled up!")
    xp = 0
    level += 1
    hp += (hp / 3) + 1
    atk += 1
    def += 1

func attack() -> void:
    attacking.emit()

func die() -> void:
    print("you died!")
    Global.game.get_tree().paused = true

func gain_xp(amt: int) -> void:
    print("you gained %s xp!" % amt)
    xp += amt

func get_atk() -> int:
    return atk + weapon.atk

func get_def() -> int:
    return def + weapon.def

func take_damage(amt: int) -> void:
    hp -= amt
    hp_change.emit()
    if hp <= 0:
        die()

func _process(delta: float) -> void:
    if in_combat:
        if timer <= atk_time:
            timer += delta
        else:
            attack()
            timer = 0.0

    
