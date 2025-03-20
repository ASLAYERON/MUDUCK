extends CharacterBody2D


@export var SPEED = 300.0
const JUMP_VELOCITY = -350.0
@onready var coyote_timer: Timer = $coyoteTimer
@onready var jumpbuffer_timer: Timer = $jumpbufferTimer

func _physics_process(delta: float) -> void:
	# GRAVITY
	if !is_on_floor():
		velocity += get_gravity() * delta
	elif !jumpbuffer_timer.is_stopped():
		jump()

	# JUMP
	if Input.is_action_just_pressed("jump") :
		if is_on_floor() or !coyote_timer.is_stopped():
			jump()
		else:
			jumpbuffer_timer.start()


	# LEFT/RIGHT
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
	var was_on_floor=is_on_floor()
	move_and_slide()
	if was_on_floor and !is_on_floor():
		coyote_timer.start()
	
func jump():
	velocity.y+= JUMP_VELOCITY
