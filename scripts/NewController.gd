extends CharacterBody3D

# Velocidad del jugador
@export var speed = 2.5
# Dirección del movimiento
var direction = Vector3.ZERO
# Gravedad
var gravity = -9.8

# Ataque
var atk:int = 5

# Referencia al AnimatedSprite3D
@onready var animated_sprite = $AnimatedSprite3D

func _physics_process(delta):
	# Reseteamos la dirección cada frame
	direction = Vector3.ZERO

	# Detectar entrada del jugador
	if Input.is_action_pressed("arriba"):
		direction.z -= 1
	if Input.is_action_pressed("abajo"):
		direction.z += 1
	if Input.is_action_pressed("izquierda"):
		direction.x -= 1
	if Input.is_action_pressed("derecha"):
		direction.x += 1

	if Input.is_action_just_pressed("atacar"):
		_on_collision_shape_3d_2_tree_entered()

	# Normalizamos la dirección para evitar que sea más rápida al moverse diagonalmente
	direction = direction.normalized()

	# Actualizar velocidad horizontal según la dirección
	if direction == Vector3.ZERO:
		# Si no hay dirección, detener movimiento horizontal
		velocity.x = 0
		velocity.z = 0
	else:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Mover al jugador usando move_and_slide
	move_and_slide()

	# Actualizar la animación según el movimiento
	update_animation()

func update_animation():
	var new_animation = ""

	if velocity.length() < 0.1:
		
		if animated_sprite.animation.contains("_up"):
			new_animation = "Idle_up"
		elif animated_sprite.animation.contains("_down"):
			new_animation = "Idle_down"
		elif animated_sprite.animation.contains("_left"):
			new_animation = "Idle_left"
		elif animated_sprite.animation.contains("_right"):
			new_animation = "Idle_right"
		else:
			new_animation = "Idle_down"
	else:
	
		if abs(velocity.z) > abs(velocity.x):  
			if velocity.z < 0:
				new_animation = "Moving_up"
			else:
				new_animation = "Moving_down"
		else:
			if velocity.x < 0:
				new_animation = "Moving_left"
			else:
				new_animation = "Moving_right"

	# Cambiar de animación solo si es necesario
	if animated_sprite.animation != new_animation:
		animated_sprite.play(new_animation)

func _on_collision_shape_3d_2_tree_entered():
	if true:
		print("ataque")
	else:
		pass