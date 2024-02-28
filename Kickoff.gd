extends State

class_name KickoffState

@export var Jumping_State : State
@export var Climbing_State : State
@onready var kickoff_cd = $"../../Kickoff CD"




func _physics_process(_delta):
	kickoff_cd.start()

func wallcheck():
	pass


func _on_kickoff_cd():
		next_state = Jumping_State
