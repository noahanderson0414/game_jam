class_name Hook
extends Area3D

var _target: HookTarget
var velocity := Vector3.ZERO
var frozen := false

@export_group("References")
@export var player: Player
@export var line: Line2D
@export_group("Properties")
@export var impulse := Vector3(0.0, 0.0, -10.0)
@export var target: HookTarget:
	get:
		return _target

func _process(delta: float) -> void:
	if line:
		line.set_point_position(1, player.camera.unproject_position(global_position))

func _physics_process(delta: float) -> void:	
	if frozen:
		return
	
	velocity += ProjectSettings.get_setting("physics/3d/default_gravity_vector") * ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	position += velocity * delta

func cast() -> void:
	velocity = global_basis * impulse

func release() -> void:
	if _target:
		_target.release()
	
	if player:
		player._on_hook_released(self)
	
	if line:
		line.queue_free()
	
	queue_free()

func _on_area_entered(area: Area3D) -> void:
	if area is Hook:
		return
	
	if area is not HookTarget or (area as HookTarget).hooked:
		release()
		return
	
	_target = area as HookTarget
	_target.hook()
	global_position = _target.hook_position.global_position
	velocity = Vector3.ZERO
	frozen = true

func _on_body_entered(body: Node3D) -> void:
	if body != player:
		release()
