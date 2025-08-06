extends Node2D

signal attacking
signal hp_change

var weapon: Weapon

var in_combat:= false
var level:= 1
var xp:= 0
var hp:= 25.0:
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
var inventory = [Item]
var max_inventory_size:= 6

func connect_signals() -> void:
    SignalBus.player_heal.connect(heal)

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
    gain_xp(enemy.xp_value)
    coins += enemy.coin_value
    victories += 1
    last_rewards = "Rewards: %s coins" % enemy.coin_value
    var loot_chance = randi_range(1,100)
    if loot_chance > enemy.loot_chance:
        return
    if inventory.size() != max_inventory_size:
        for item_id in enemy.loot:
            var item = Item.new(item_id)
            var loot_roll = randi_range(1,100)
            var other_reward = null
            if loot_roll < item.loot_chance and loot_roll > 0:
                other_reward = item
                inventory.append(other_reward)
            loot_roll -= item.loot_chance
            if other_reward != null:
                last_rewards += ", %s" % other_reward.item_name
            

func die() -> void:
    print("you died!")
    Global.game.get_tree().paused = true

func gain_xp(amt: int) -> void:
    print("you gained %s xp!" % amt)
    xp += amt
    if xp >= Global.level_xp[level]:
        level_up()

func get_atk() -> int:
    return atk + weapon.atk + atk_buff

func get_def() -> int:
    return def + weapon.def

func take_damage(amt: int) -> void:
    hp -= amt
    hp_change.emit()
    if hp <= 0:
        die()

func heal(amt: float) -> void:
    hp += amt
    if hp >= max_hp:
        hp = max_hp

func _process(delta: float) -> void:
    if in_combat:
        if timer <= atk_time + (weapon.atk_time * atk_time):
            timer += delta
        else:
            attack()
            timer = 0.0

    
