extends State

class_name JumpingState

@export var Moving_State : State
@export var Climbing_State : State
@export var double_jump_velocity : float = - 300
@export var double_jump_anim : String = "Double_Jump"
@export var running  : String = "Move"
@onready var jump_timer = $"../../DoubleJump"


func state_process(_delta):
	if(character.is_on_floor_only()):
		next_state = Moving_State
		playback.travel("Move")

	if(character.is_on_wall_only()):
		next_state = Climbing_State

func state_input(event : InputEvent):
	if(event.is_action_pressed("ui_accept") && jump_timer.is_stopped()):
		jump_timer.start()
		double_jump()

func on_exit():
	if(next_state == Moving_State):
		jump_timer.stop()
	if(next_state == Climbing_State):
		jump_timer.stop()

func double_jump():
	character.velocity.y = double_jump_velocity
	has_double_jumped = true
	playback.travel("Double_Jump")

func _on_double_jump_timeout():
	pass # Replace with function body.
