extends State

class_name IdleState
@export var jump_velocity : float = - 500
@export var MovingState : State
@export var JumpingState: State


func state_input(event : InputEvent):
	if(event.is_action_pressed("ui_accept")):
		jump()

func jump():
	character.velocity.y = jump_velocity
	next_state = JumpingState

func _physics_process(delta):
	if character.velocity.y != 0:
		next_state = MovingState
		return
	if character.velocity.x != 0:
		next_state = MovingState
		return
