extends CharacterBody3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.5 
		get_node("Camera3D").rotation_degrees.x -= event.relative.y * 0.2
		get_node("Camera3D").rotation_degrees.x = clamp(
			get_node("Camera3D").rotation_degrees.x, -60.0, 60.0
		)
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
func _physics_process(delta: float):
	const SPEED = 5.5
	
	var input_direction_2d = Input.get_vector(
		"mouve_left", "mouve_right", "mouve_up", "mouve_down"
	)
	var input_direction_3d = Vector3(
		input_direction_2d.x, 0.0, input_direction_2d.y
	)
	var direction = transform.basis * input_direction_3d
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	velocity.y -= 20 *  delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y  = 10.0
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0.0
	
	move_and_slide()
	
	if Input.is_action_pressed("shoot") and %Timer.is_stopped():
		bullet_load()
	
func bullet_load():
	const BULLET_3D = preload("res://player/projectile/bullet_3d.tscn")
	var bullet = BULLET_3D.instantiate()
	%Marker3D.add_child(bullet)
	
	bullet.global_transform = %Marker3D.global_transform
	
	%Timer.start()
	%AudioStreamPlayer.play()
