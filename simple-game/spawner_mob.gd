extends Node3D

signal mob_spawned(mob)

@export  var mob_to_spown: PackedScene = null

@onready var marker_3d: Marker3D = %Marker3D
@onready var timer: Timer = %Timer


func _on_timer_timeout():
	var new_mob = mob_to_spown.instantiate()
	add_child(new_mob)
	new_mob.global_position = %Marker3D.global_position
	
	mob_spawned.emit(new_mob)
