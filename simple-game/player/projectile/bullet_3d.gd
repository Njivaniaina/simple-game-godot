extends Area3D

const SPEED  = 40.0
const RANGE = 40.0

var travelle_distance = 0.0 

func _physics_process(delta: float):
	position += -transform.basis.z * SPEED * delta
	travelle_distance += SPEED * delta
	if travelle_distance > RANGE:
		queue_free()
		

func _on_body_entered(body: Node3D):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
