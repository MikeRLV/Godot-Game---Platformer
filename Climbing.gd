extends State

class_name ClimbingState
@export var friction = 0.03
@export var wall_jump_pushback: float = 300
@export var jump_height : float = -200
@warning_ignore("shadowed_global_identifier")
@export var MovingState: State
@warning_ignore("shadowed_global_identifier")
@export var JumpingState: State
@warning_ignore("shadowed_global_identifier")
@onready var ltimer = $"../../LWallJump"
@onready var rtimer = $"../../RWallJump"



var rwallslide
var lwallslide
var wallgrab
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity = Vector2()
var wallslide

func _physics_process(_delta):
	state_check()
	jump()
	rwall_slide()
	lwall_slide()
	rwall_jump()
	lwall_jump()
	reset_timer()
	#debug()

	

#func debug():
	#if rtimer.is_stopped():
		#print("Rtimer Stopped")
	#else:
		#print("Rtimer On")

func state_check():
	if(character.is_on_floor_only()):
		next_state = MovingState
	if(character.velocity.y != 0) && wallslide==false:
		next_state = JumpingState
		

func rwall_slide():
	rwallslide = false
	if character.is_on_wall_only() && (Input.is_action_pressed("ui_right")):
		character.velocity.y =  friction
		rwallslide = true
		rwall_grab()
		return

func lwall_slide():
	lwallslide = false
	if character.is_on_wall_only() && (Input.is_action_pressed("ui_left")):
		character.velocity.y = friction
		lwallslide = true
		lwall_grab()
		return

func wallcheck():
	if rwallslide == true:
		wallslide = true
	if lwallslide == true:
		wallslide = true
	return

func lwall_grab():
		if lwallslide == true && Input.is_action_pressed("ui_accept"):
			character.velocity.y = -16.35
			wallgrab = true
			lwall_jump()
		return

func rwall_grab():
		if rwallslide == true && Input.is_action_pressed("ui_accept"):
			character.velocity.y = -16.35
			wallgrab = true
			rwall_jump()
		return

#&& rtimer.is_stopped(): is causing the break in the r wall jump code. Try to find out why it's not working.

func rwall_jump():
	if rwallslide == true && wallgrab == true:
		if Input.is_action_just_pressed("ui_left"):
			character.velocity.x = -wall_jump_pushback * 4
			character.velocity.y = jump_height * 2
			next_state = JumpingState
			rtimer.start()
			return

func lwall_jump():
	if lwallslide == true && wallgrab == true && ltimer.is_stopped():
		if Input.is_action_just_pressed("ui_right"):
			character.velocity.x = wall_jump_pushback * 4
			character.velocity.y = jump_height * 2
			next_state = JumpingState
			ltimer.start()
			return

func reset_timer():
	if character.is_on_floor():
		ltimer.stop()
	if character.is_on_floor():
		rtimer.stop()

func _on_r_wall_jump_timeout():
	pass # Replace with function body.
func _on_l_wall_jump_timeout():
	pass # Replace with function body.
