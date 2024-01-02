extends State

class_name MovingState
@export var IdleState : State
@export var jump_velocity : float = -400
@export var JumpingState : State
@export var ClimbingState : State
#var wallslide
var velocity = Vector2()
var is_moving


func state_input(event : InputEvent):
	if(event.is_action_pressed("ui_accept")):
		jump()

func jump():
	character.velocity.y = jump_velocity
	next_state = JumpingState
	
	
func _physics_process(delta):
	state_check()
	if character.velocity.x == 0 && character.is_on_floor():
		next_state = IdleState
		return
func state_check():
	if(character.is_on_wall_only()):
		next_state = ClimbingState
		return

#func idlecheck():
	#character.is_moving = false
	#next_state = IdleState



