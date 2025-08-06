extends Node

var game: Node
var new_scene: Node

var scene_ref:= {
	Enums.GameState.HOME: "res://home.tscn",
	Enums.GameState.SHOP: "res://shop.tscn",
	Enums.GameState.INVENTORY: "res://inventory.tscn",
	Enums.GameState.COMBAT: "res://combat.tscn",
	Enums.GameState.CRAFT: "res://craft.tscn",
	Enums.GameState.PAUSE: "res://pause.tscn",
}

func start_scene(state: Enums.GameState) -> void:
	new_scene = load(scene_ref[state]).instantiate()
	game.ROOT_CONTROL.add_child(new_scene)
	game.active_scenes[state] = new_scene

func change_scene(state: Enums.GameState) -> void:
	game.ROOT_CONTROL.remove_child(new_scene)
	if !game.active_scenes.has(state):
		new_scene = load(scene_ref[state]).instantiate()
	else:
		new_scene = game.active_scenes[state]
	game.ROOT_CONTROL.add_child(new_scene)
	game.active_scenes[state] = new_scene

func end_scene(state: Enums.GameState) -> void:
	for scene_id in game.active_scenes:
		var scene = game.active_scenes[scene_id]
		if scene == new_scene:
			game.active_scenes.erase(scene_id)
	new_scene.queue_free()
	new_scene = load(scene_ref[state]).instantiate()
	game.ROOT_CONTROL.add_child(new_scene)
	game.active_scenes[state] = new_scene
