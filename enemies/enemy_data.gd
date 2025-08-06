class_name EnemyData extends Resource

@export var can_attack:= true
@export var enemy_name: String
@export var hp: int
@export var atk: int
@export var def: int
@export var atk_time: float
var timer:= 0.0
@export var xp_value: int
@export var coin_value_min: int
@export var coin_value_max: int
@export var loot: Array[Enums.Items]
@export var loot_chance:= 5
@export var enemy_scene: PackedScene