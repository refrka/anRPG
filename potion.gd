class_name Potion extends Node

var item_name:= "Potion"
var tier: int
var hp_recovery: int:
    get: return tier_hp[tier]
var tier_hp = [10,20,50]
var tier_cost = [10, 50, 100]
var texture = preload("res://sprites/potion.png")

func _init(_tier: int) -> void:
    tier = _tier
    item_name += " (tier %s)" % tier

func use() -> void:
    Global.game.player.hp += tier_hp[tier]