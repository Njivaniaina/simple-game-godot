extends RigidBody3D

var health = 3.0

signal died

var speed = randf_range(2.0, 4.0)
@onready var damage: AudioStreamPlayer3D = %damage
@onready var died_sound: AudioStreamPlayer3D = %died


@onready var bat_model: Node3D = %bat_model
@onready var timer: Timer = %Timer

@onready var player = get_node("/root/Game/Player")

func _physics_process(delta: float):
	var direction = global_position.direction_to(player.global_position)
	direction.y = 0
	linear_velocity = direction * speed
	#bat_model.rotation.z = 0
	#bat_model.rotation.x = 0
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI
	#bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI/2

func take_damage():
	if health == 0:
		return
	
	bat_model.hurt()
	
	health -= 1
	damage.play()
	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		var direction = -1.0 * global_position.direction_to(player.global_position)
		var random_upward_force = Vector3.UP * randf_range(1.0, 5.0)
		apply_central_impulse(direction * 10.0 + random_upward_force)
		timer.start()
		died_sound.play()
		

func _on_timer_timeout() -> void:
	queue_free()
	died.emit()
