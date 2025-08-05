class_name Weapon extends Node

var atk: int
var def: int
var reach: int


func _init(weapon_type: String) -> void:
    if weapon_type == "bow":
        atk = 3
        def = 0
        reach = 2
    elif weapon_type == "spear":
        atk = 2
        def = 1
        reach = 1
    elif weapon_type == "sword":
        atk = 3
        def = 2
        reach = 0