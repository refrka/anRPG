extends Node

var state: int:
    get: return state
    set(value):
        state = value
        state_update(value)

@onready var ROOT_CONTROL = $RootControl

func _ready() -> void:
    SceneManager.game = self
    state = 0

func state_update(new_state: Enums.GameState) -> void:
    SceneManager.start_scene(new_state)

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("state_change"):
        if state == Enums.GameState.size() - 1:
            state = 0
        else:
            state = state + 1
