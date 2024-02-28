extends State

class_name LKickoffState

@export var Jumping_State : State
@export var Climbing_State : State
@export var wall_jump_pushback: float = 300
@export var jump_height : float = -200
@onready var kickoff_cd = $"../../wall_hop_timer"
@export var jump_anim : String = "Jump"
@onready var animation_tree = $"../../AnimationTree"
#
#func _physics_process(_delta):
	##print(kickoff_cd.time_left)
	#pass
func on_enter():
	wall_hop()



func wall_hop():
	kickoff_cd.start()
	character.velocity.x = wall_jump_pushback * 3.3
	character.velocity.y = jump_height * 2.2
	playback.travel("Jump")
	character.anim.flip_h = false


func _on_wall_hop_timer_timeout():
	next_state = Jumping_State
