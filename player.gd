extends CharacterBody2D

signal using

@export var speed : float = 300.0
@export var jump_velocity: float = -400.0
@export var double_jump_velocity: float = - 200
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CSM
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@export var move_anim : String = "Move"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("ui_left", "ui_right","ui_down", "ui_accept")
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_direction()
	
	

func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)

func state_input(event : InputEvent):
	if(event.is_action_pressed("ui_accept")):
		emit_signal("using")
		SignalBus.emit_signal("using")
		print("Player_script:using")
	
func  update_direction():
	if direction.x < 0:
		anim.flip_h = true
	elif direction.x > 0:
		anim.flip_h = false
	#print(direction.x)
