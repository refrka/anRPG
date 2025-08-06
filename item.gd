class_name Item extends Node

var data_ref:= {
    Enums.Items.POTION_HEAL: "res://items/potion.tscn",
    Enums.Items.BUFF_ATK: "res://items/buff.tscn",
}
var type: Enums.Items
var data: Resource
var node: Node
var item_name: String
var cost: int
var value_change: float
var loot_chance: int

func _init(item_id: Enums.Items) -> void:
    type = item_id
    data = load(data_ref[item_id])

func load_item() -> Node:
    node = data.item_scene.instantiate()

    item_name = data.item_name
    cost = data.cost
    value_change = data.value_change
    loot_chance = data.loot_chance
    return node

func use() -> void:
    if type == Enums.Items.POTION_HEAL:
        SignalBus.player_heal.emit(value_change)