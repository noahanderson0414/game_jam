class_name Player
extends RigidBody3D

var hooks: Array[Hook]

@export_group("References")
@export var camera: Camera3D
@export var hook_spawn: Node3D
@export var hook_scene: PackedScene
@export_group("Rotation")
@export var rotation_speed := 0.005
@export_group("Rod")
@export var reel_force := 50.0

@onready var target_rotation := Vector3(camera.rotation.x, rotation.y, 0.0)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var delta: Vector2 = -event.relative * rotation_speed
		target_rotation.x = clampf(target_rotation.x + delta.y, -PI / 2.0, PI / 2.0)
		target_rotation.y = wrapf(target_rotation.y + delta.x, -TAU, TAU)

func _physics_process(_delta: float) -> void:
	camera.rotation.x = target_rotation.x
	rotation.y = target_rotation.y
	
	if Input.is_action_just_pressed("cast_rod"):
		cast_rod()
	
	if Input.is_action_pressed("reel_rod"):
		reel_rod()
	
	if Input.is_action_just_released("reel_rod"):
		release_rod()

func cast_rod() -> void:
	var hook := hook_scene.instantiate()
	hooks.push_back(hook)
	hook.player = self
	get_tree().root.add_child(hook)
	hook.global_transform = hook_spawn.global_transform
	hook.cast()

func reel_rod() -> void:
	if len(hooks) == 0:
		return
	
	var hook: Hook = hooks.front()
	if not hook or not hook.target:
		return
	
	var direction := global_position.direction_to(hook.global_position)
	var force := direction * reel_force
	apply_central_force(force)

func release_rod() -> void:
	if len(hooks) == 0:
		return
	
	var hook: Hook = hooks.pop_front()
	if not hook or not hook.target:
		return
	
	hook.release()

func _on_hook_released(hook: Hook) -> void:
	var i := 0
	while i < len(hooks):
		if hooks[i] == hook:
			hooks.remove_at(i)
		else:
			i += 1
