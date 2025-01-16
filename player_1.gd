extends CharacterBody2D

const SPEED = 600.0
const ACCELERATION = 3500.0
const FRICTION = 3000.0
const JUMP_VELOCITY = -1000.0

# Get AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Get PlayerIcon
@onready var playerIcon1: Sprite2D = $"../Control/PlayerIcon/Panel1/Sprite2D"

# Get other player
@onready var player2: CharacterBody2D = $"../Player2"

var health = 100
var points = 0

func _ready() -> void:
	self.visible = false
	set_process(true)
	set_physics_process(false)
	position.x = 200
	position.y = 50

func _process(delta: float) -> void:
	if(self.visible == true):
		set_physics_process(true)
	
	if(position.y >= 1000):
		health = 0
	
	if(health <= 0):
		if(player2.points >= 4):
			pass
		elif(player2.points < 4):
			position.y = -200
			position.x = 375
			health = 100
			player2.points += 1

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_jump()
	var input_axis := Input.get_axis("MoveR1", "MoveL1")
	movement(input_axis, delta)
	
	update_animation(input_axis)
	
	move_and_slide()
func handle_gravity(delta):
	if(!is_on_floor()):
		velocity += get_gravity() * delta
func handle_jump():
	if is_on_floor():
		if Input.is_action_pressed("Jump1"):
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("Jump1") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
func movement(input_axis, delta):
	if(input_axis):
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0 * input_axis, FRICTION * delta)
func update_animation(input_axis):
	if(input_axis != 0):
		animated_sprite_2d.flip_h = (input_axis < 0)
		if(playerIcon1.frame == 0):
			animated_sprite_2d.play("GRun")
		elif(playerIcon1.frame == 1):
			animated_sprite_2d.play("SRun")
		
		# Off set bug fix
		if(animated_sprite_2d.flip_h == false):
			animated_sprite_2d.offset.x = 0
		elif(animated_sprite_2d.flip_h == true):
			animated_sprite_2d.offset.x = 3
	else:
		if(playerIcon1.frame == 0):
			animated_sprite_2d.play("GIdle")
		elif(playerIcon1.frame == 1):
			animated_sprite_2d.play("SIdle")
		
		# Off set bug fix
		if(animated_sprite_2d.flip_h == false):
			animated_sprite_2d.offset.x = 3
		elif(animated_sprite_2d.flip_h == true):
			animated_sprite_2d.offset.x = 0
	if(!is_on_floor()):
		if(playerIcon1.frame == 0):
			animated_sprite_2d.play("GJump")
		elif(playerIcon1.frame == 1):
			animated_sprite_2d.play("SJump")
		
		# Off set bug fix
		if(animated_sprite_2d.flip_h == false):
			animated_sprite_2d.offset.x = 3
		elif(animated_sprite_2d.flip_h == true):
			animated_sprite_2d.offset.x = 0
