extends State

class_name MovingState
@export var Idle_State : State
@export var jump_velocity : float = -400
@export var Jumping_State : State
@export var Climbing_State : State
@export var jump_anim : String = "Jump"
@export var move_anim : String = "Move"
@onready var animation_tree = $"../../AnimationTree"
@onready var jump_timer = $"../../DoubleJump"
@onready var camera_2d = $"../../Camera2D"


func state_input(event : InputEvent):
	if(event.is_action_pressed("ui_accept")):
		jump()

func jump():
	character.velocity.y = jump_velocity
	next_state = Jumping_State
	playback.travel("Jump")


func _physics_process(_delta):
	wall_check()
	idle_check()
	falling()

func wall_check():
	if(character.is_on_wall_only()):
		next_state = Climbing_State

func idle_check():
	if character.velocity.x == 0 && character.is_on_floor():
		next_state = Idle_State

func falling():
	if character.velocity.y > 0 && jump_timer.is_stopped():
		next_state = Jumping_State
		playback.travel("Jump")



func _on_double_jump_timeout():
	pass # Replace with function body.
