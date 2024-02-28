extends State

class_name ClimbingState

@export var friction = 0.03
@export var wall_jump_pushback: float = 300
@export var jump_height : float = -200
@export var Moving_State: State
@export var Jumping_State: State
@export var rKickoff_State : State
@export var lKickoff_State : State
@onready var ltimer = $"../../LWallJump"
@onready var rtimer = $"../../RWallJump"
@export var wall_slide_anim : String = "Wall_slide"
@export var wall_cling_anim : String = "Wall_cling"
@export var jump_anim : String = "Jump"

var rwallslide
var lwallslide
var wallgrab
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity = Vector2()
var wallslide
var hold
var r_timer_on
var l_timer_on

func _physics_process(_delta):
	state_check()
	jump()
	wall_slide()
	#lwall_slide()
	#reset_timer()
	wallcheck()
	#debug()
	#r_timer_check()
	#rtimer.start()
	#ltimer.start()
	wall_grabity()
	timer_start()
func debug():
	if rtimer.is_stopped():
		print("Rtimer Stopped")
	else:
		print("Rtimer On")
	#if ltimer.is_stopped():
		#print("ltimer Stopped")
	#else:
		#print("ltimer On")


func state_check():
	if(character.is_on_floor_only()):
		next_state = Moving_State
		playback.travel("Move")
	if(character.velocity.y != 0) && !character.is_on_wall_only():
		next_state = Jumping_State
		playback.travel("Jump")
	
func spacehold():
	hold = Input.is_action_pressed("ui_accept")
	#print(hold)


func wall_grabity():
		spacehold()
		rwall_grabity()
		lwall_grabity()
func rwall_grabity():
	rtimer.start()
	if rtimer.time_left != 0 && wallgrab == true:
		character.velocity.y = -16.35
		playback.travel("Wall_cling")
		next_state = rKickoff_State
func lwall_grabity():
	if ltimer.time_left != 0 && wallgrab == true:
		ltimer.start()
		character.velocity.y = -16.35
		playback.travel("Wall_cling")
	if ltimer.time_left == 0:
		next_state = lKickoff_State

func timer_start():
	ltimer.start()
	rtimer.start()

func wall_slide():
	rwall_slide()
	lwall_slide()
func rwall_slide():
	rwallslide = false
	if character.is_on_wall_only() && (Input.is_action_pressed("ui_right")):
		character.velocity.y =  friction
		rwallslide = true
		#if hold == true :
			#rwall_grabity()
		

func lwall_slide():
	lwallslide = false
	if character.is_on_wall_only() && (Input.is_action_pressed("ui_left")):
		character.velocity.y = friction
		lwallslide = true
		lwall_grabity()
		#if hold == true :
			#lwall_grabity()

#func lwall_jump():
		#wallgrab = false
		#character.velocity.x = wall_jump_pushback
		#character.velocity.y = jump_height
		#next_state = Kickoff_State
		#ltimer.start()
		#return

#
#
func wallcheck():
	if rwallslide == true:
		wallslide = true
	if lwallslide == true:
		wallslide = true
	if wallslide == true && hold == false:
		playback.travel("Wall_slide")
	return
	
#



#func lwall_grab():
		#if hold == true:
			#wallgrab = true
			##character.velocity.y = -16.35
			#await get_tree().create_timer(1.0).timeout
			#lwall_jump()
		#return
#
#func rwall_grab():
		#if hold== true:
			#wallgrab = true
			##character.velocity.y = -16.35
			#if hold == false:
				#await get_tree().create_timer(1.0).timeout
			#rwall_jump()
		#return
#
##&& rtimer.is_stopped(): is causing the break in the r wall jump code. Try to find out why it's not working.
#
#func rwall_jump():
		#wallgrab = false
	##if rtimer.is_stopped():
		##if Input.is_action_just_pressed("ui_left"):
		#character.velocity.x = -wall_jump_pushback * 4
		#character.velocity.y = jump_height * 2
		#next_state = KickoffState
		#rtimer.start()
		#return
#
#func lwall_jump():
		#wallgrab = false
	##if ltimer.is_stopped():
	##if lwallslide == true && wallgrab == true && ltimer.is_stopped():
		##if Input.is_action_just_pressed("ui_right"):
		#character.velocity.x = wall_jump_pushback
		#character.velocity.y = jump_height
		#next_state = KickoffState
		#ltimer.start()
		#return
#
##func reset_timer():
	##lreset_timer()
	##rreset_timer()
##func lreset_timer():
	##if character.is_on_floor():
		##ltimer.stop()
##func rreset_timer():
	##if character.is_on_floor():
		##rtimer.stop()
#func wait_for_ltimer():
	#ltimer.start()
	#ltimer.timeout()
	#
#func r_timer_check():
	#if rtimer.time_left != 0:
		#r_timer_on = true
	#if rtimer.time_left == 0:
		#r_timer_on = false
	##print(r_timer_on)
func r_timeout():
	pass


func l_timeout():
	pass
