class_name Weapon extends Node

var atk: int
var def: int
var reach: int
var atk_time: float


func _init(weapon_type: String) -> void:
    if weapon_type == "bow":
        atk = 3
        def = 0
        reach = 2
        atk_time = 0.1
    elif weapon_type == "spear":
        atk = 2
        def = 2
        reach = 1
        atk_time = 0.0
    elif weapon_type == "sword":
        atk = 3
        def = 2
        reach = 0
        atk_time = -0.2