extends State

class_name JumpingState

@export var MovingState : State
@export var ClimbingState : State
@export var double_jump_velocity : float = - 300
var velocity = Vector2()
@onready var ltimer = $"../../LWallJump"
@onready var rtimer = $"../../RWallJump"

var has_double_jumped = false


func state_process(delta):
	if(character.is_on_floor_only()):
		next_state = MovingState
	
	if(character.is_on_wall_only()) && (Input.is_action_pressed("ui_right")):
		next_state = ClimbingState
		
	if(character.is_on_wall_only()) && (Input.is_action_pressed("ui_left")):
		next_state = ClimbingState
	

func state_input(event : InputEvent):
	if(event.is_action_pressed("ui_accept") && ! has_double_jumped):
		double_jump()

func on_exit():
	if(next_state == MovingState):
		has_double_jumped = false
	if(next_state == ClimbingState):
		has_double_jumped = false
func double_jump():
	character.velocity.y = double_jump_velocity
	has_double_jumped = true
	#ltimer.stop()
	#rtimer.stop()
