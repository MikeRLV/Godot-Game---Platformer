extends State

class_name ClimbingState

@export var friction = 0.03
@export var wall_jump_pushback: float = 300
@export var jump_height : float = -200
@export var Moving_State: State
@export var Jumping_State: State
@export var rKickoff_State : State
@export var lKickoff_State : State
@export var wall_slide_anim : String = "Wall_slide"
@export var wall_cling_anim : String = "Wall_cling"
@export var jump_anim : String = "Jump"
@export var move_anim : String = "Idle"
@onready var l_wall = $"../../LWallCollide"
@onready var r_wall = $"../../RWallCollide"
@onready var wall_hop_timer = $"../../wall_hop_timer"

func _physics_process(_delta):
	state_check()
	jump()
	lwall_slide()
	rwall_slide()
	rwall_grab()
	lwall_grab()

func state_check():
	if(character.is_on_floor()):
		next_state = Moving_State
		playback.travel("Move")
	if(character.velocity.y != 0) && !character.is_on_wall_only():
		next_state = Jumping_State
		

func lwall_slide():
	if character.is_on_wall() and Input.is_action_pressed("ui_left"):
		character.velocity.y = friction
		playback.travel("Wall_slide")


func rwall_slide():
	if character.is_on_wall() and Input.is_action_pressed("ui_right"):
		character.velocity.y = friction
		playback.travel("Wall_slide")


func rwall_grab():
	if Input.is_action_pressed("ui_accept") && r_wall.is_colliding():
		character.velocity.y = -16.35
		playback.travel("Wall_cling")
	if Input.is_action_just_released("ui_accept") && r_wall.is_colliding():
		next_state = rKickoff_State

func lwall_grab():
	if Input.is_action_pressed("ui_accept") && l_wall.is_colliding():
		character.velocity.y = -16.35
		playback.travel("Wall_cling")
	if Input.is_action_just_released("ui_accept") && l_wall.is_colliding():
		next_state = lKickoff_State

func _on_wall_hop_timer_timeout():
	pass
