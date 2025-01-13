extends CharacterBody3D

#Parámetros del goblin
@export var speed = 3.0  
@export var detection_range = 10.0  #Rango de detección
var gravity = -9.8
# Referencia al jugador
@export var player: NodePath
# Referencia al AnimatedSprite3D
@onready var animated_sprite = $AnimatedSprite3D


func _physics_process(delta):
    if player and has_node(player):
        var player_node = get_node(player)
        var direction_to_player = player_node.global_transform.origin - global_transform.origin
        var distance_to_player = direction_to_player.length()

        if distance_to_player <= detection_range:
            # Mover hacia el jugador
            move_towards_player(direction_to_player.normalized())
        else:
            # Cambiar a animación Idle si el jugador está fuera de rango
            if animated_sprite.animation != "Idle":
                animated_sprite.play("Idle")

    else:
        print("Player node not found!")

    # Aplicar gravedad
    if not is_on_floor():
        velocity.y += gravity * delta
    else:
        velocity.y = 0
	

func move_towards_player(direction):
    # Actualizar la velocidad del goblin
    velocity.x = direction.x * speed
    velocity.z = direction.z * speed

    # Mover el goblin
    move_and_slide()

    # Cambiar a animación de movimiento
    if animated_sprite.animation != "Moving":
        animated_sprite.play("Moving")


    flip_sprite(direction.x)

func flip_sprite(direction_x):
    if direction_x < 0:
        animated_sprite.flip_h = false
    else:
        animated_sprite.flip_h = true