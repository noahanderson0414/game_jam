class_name PlayerCamera
extends Camera3D

@onready var rb : RigidBody3D = get_parent()
@export var fovPerUPerS : float = 0
var baseFOV : float = 0

func _ready() -> void:
	baseFOV = fov

func _process(delta: float) -> void:
	fov = fovPerUPerS * rb.linear_velocity.length() + baseFOV
