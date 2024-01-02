extends State

class_name WallhopState
@export var JumpingState: State
@export var MovingState: State 

func _process(delta):
	jump()
	
