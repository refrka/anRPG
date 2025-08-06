extends Node2D

signal attacking
signal hp_change

var weapon: Weapon

var in_combat:= false
var level:= 1
var xp:= 0:
    set(value):
        if value != 0:
            xp += value
            if xp >= Global.level_xp[level]:
                level_up()
        else:
            xp = value
var hp:= 25:
    set(value):
        if value > max_hp:
            hp = max_hp
        else:
            hp = value
var max_hp:= 25
var atk:= 1
var atk_buff:= 0
var def:= 1
var atk_time:= 2.0
var timer:= 0.0
var coins:= 0
var victories:= 0
var last_rewards:= ""
var inventory = []
var max_inventory_size:= 6

func level_up() -> void:
    print("you leveled up!")
    xp = 0
    level += 1
    max_hp += (max_hp / 3) + 1
    hp = max_hp
    atk += 1
    def += 1

func attack() -> void:
    attacking.emit()

func gain_combat_rewards(enemy: Node) -> void:
    xp += enemy.xp_value
    coins += enemy.coin_value
    victories += 1
    last_rewards = "Rewards: %s" % enemy.coin_value
    var loot_roll = randi_range(1,100)
    print(loot_roll)
    if inventory.size() != max_inventory_size:
        for item in enemy.other_rewards:
            var other_reward = null
            if loot_roll < item["chance"] and loot_roll > 0:
                other_reward = item["item"]
                inventory.append(other_reward)
            loot_roll -= item["chance"]
            if other_reward != null:
                last_rewards += ", %s" % other_reward.item_name
            

func die() -> void:
    print("you died!")
    Global.game.get_tree().paused = true

func gain_xp(amt: int) -> void:
    print("you gained %s xp!" % amt)
    xp += amt

func get_atk() -> int:
    return atk + weapon.atk + atk_buff

func get_def() -> int:
    return def + weapon.def

func take_damage(amt: int) -> void:
    hp -= amt
    hp_change.emit()
    if hp <= 0:
        die()

func _process(delta: float) -> void:
    if in_combat:
        if timer <= atk_time + (weapon.atk_time * atk_time):
            timer += delta
        else:
            attack()
            timer = 0.0

    
