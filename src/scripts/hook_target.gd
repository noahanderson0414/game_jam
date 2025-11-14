class_name HookTarget
extends Area3D

var _hooked := false

@export_group("References")
@export var collision_shape: CollisionShape3D
@export var hook_position: Node3D
@export_group("Properties")
@export var hooked: bool:
	get:
		return _hooked

func hook() -> void:
	_hooked = true

func release() -> void:
	_hooked = false
