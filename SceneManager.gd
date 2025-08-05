extends Node

var game: Node
var new_scene: Node
var old_scene: Node

var scene_ref:= {
	Enums.GameState.HOME: "res://home.tscn",
	Enums.GameState.COMBAT: "res://combat.tscn",
	Enums.GameState.CRAFT: "res://craft.tscn",
	Enums.GameState.PAUSE: "res://pause.tscn",
}

func start_scene(state: Enums.GameState) -> void:
	if new_scene != null:
		old_scene = new_scene
		old_scene.queue_free()
	new_scene = load(scene_ref[state]).instantiate()
	game.ROOT_CONTROL.add_child(new_scene)
