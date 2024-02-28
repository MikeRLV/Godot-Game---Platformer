extends State

class_name IdleState
@export var jump_velocity : float = - 500
@export var Moving_State : State
@export var Jumping_State: State
@onready var jump_timer = $"../../DoubleJump"


func state_input(event : InputEvent):
	if(event.is_action_pressed("ui_accept")):
		jump()

func jump():
	character.velocity.y = jump_velocity
	next_state = Jumping_State
	playback.travel("Jump")

func _physics_process(_delta):
	jump_check()
	if character.velocity.x != 0:
		next_state = Moving_State

func jump_check():
		if character.velocity.y != 0 && jump_timer.is_stopped():
			playback.travel("Jump")
			next_state = Jumping_State
