class_name Player
extends RigidBody3D

@export_group("References")
@export var camera: Camera3D
@export var hook_spawn: Node3D
@export var hook_scene: PackedScene
@export_group("Rotation")
@export var rotation_speed := 0.005

@onready var target_rotation := Vector3(camera.rotation.x, rotation.y, 0.0)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var delta: Vector2 = -event.relative * rotation_speed
		target_rotation.x = clampf(target_rotation.x + delta.y, -PI / 2.0, PI / 2.0)
		target_rotation.y = wrapf(target_rotation.y + delta.x, -TAU, TAU)

func _physics_process(delta: float) -> void:
	camera.rotation.x = target_rotation.x
	rotation.y = target_rotation.y
	
	if Input.is_action_just_pressed("cast_rod"):
		spawn_hook()

func spawn_hook() -> void:
	var hook := hook_scene.instantiate()
	get_tree().root.add_child(hook)
	hook.global_transform = hook_spawn.global_transform
	hook.cast()
