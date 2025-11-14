class_name Damageable
extends Node3D

@onready var healthbar : Healthbar = $Healthbar
@export var health : float : set = _set_health
@export var max_health = 10

func _ready():
	health = max_health
	healthbar.init_health(health)

func _set_health(value):
	print("Setting Health to: " + str(value))
	healthbar.health = value
	health = value
	if health <= 0:
		die()

func die():
	print("Boned")
	var player_rb : RigidBody3D = get_parent()
	player_rb.position = Vector3.ZERO
	player_rb.linear_velocity = Vector3.ZERO
	max_health += 2
	health = max_health
	healthbar.init_health(health)
	pass



func _on_body_entered(body: Node) -> void:
	if body.name == "Spike Collision":
		health = health - 1
