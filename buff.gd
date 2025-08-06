class_name Buff extends Node

var item_name:= "Buff"
var tier: int
var stat: String
var tier_amt = [1, 2, 4]
var tier_duration = [12, 7, 4]
var texture = preload("res://sprites/buff.png")

func _init(_tier: int) -> void:
    tier = _tier
    item_name += " (tier %s)"  % tier

func use() -> void:
    Global.game.player.atk_buff = tier_amt[tier]
