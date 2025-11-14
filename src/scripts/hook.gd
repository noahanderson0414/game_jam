class_name Hook
extends RigidBody3D

@export var impulse := Vector3(0.0, 0.0, -10.0)
@export var tween_time := 0.1

func cast() -> void:
	apply_impulse(global_basis * impulse)

func _on_body_entered(body: Node) -> void:
	if body is not HookTarget:
		return
	
	(body as HookTarget).hook()
	var tween := get_tree().create_tween()
	var target_position := (body as HookTarget).hook_position.global_position
	tween.tween_property(self, "global_position", target_position, tween_time)
	freeze = true
