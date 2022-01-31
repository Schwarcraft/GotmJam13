extends KinematicBody2D

export (int) var speed = 200
export (int) var teleport_range = 50
var teleport_range_squared

var velocity = Vector2()

onready var sprite : AnimatedSprite = $Sprite

func _ready():
	teleport_range_squared = teleport_range* teleport_range

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		sprite.flip_h = false
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		sprite.flip_h = true
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1

	if Input.is_action_just_pressed("teleport"):
		teleport()
	velocity = velocity.normalized() * speed


func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func teleport():
	var mouse_pos = get_global_mouse_position()
	if position.distance_squared_to(mouse_pos) > teleport_range_squared:
		print('Too far')
		var dir = position.direction_to(mouse_pos)
		self.position += dir*teleport_range
		return

	position = mouse_pos
