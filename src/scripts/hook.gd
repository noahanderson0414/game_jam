class_name Hook
extends RigidBody3D

@export var impulse := Vector3(0.0, 0.0, -10.0)

func cast() -> void:
	apply_impulse(global_basis * impulse)
