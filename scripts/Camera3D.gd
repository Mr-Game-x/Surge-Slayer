extends Camera3D

@export var object_to_follow: Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotation = object_to_follow.position