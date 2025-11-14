class_name HookTarget
extends StaticBody3D

@export_group("References")
@export var collision_shape: CollisionShape3D
@export var hook_position: Node3D

func hook() -> void:
	collision_shape.set_deferred("disabled", true)

func release() -> void:
	collision_shape.set_deferred("disabled", false)
