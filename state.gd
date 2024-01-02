extends Node

class_name State

@export var can_move : bool = true
var character : CharacterBody2D
var next_state : State
#var velocity = Vector2()

func state_process(delta):
	pass

func state_input(_event : InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass

func jump():
	pass

func wall_slide():
	pass

func idlecheck():
	pass

func wall_hit():
	pass

func double_jump():
	pass
	
#func reset_timer():
	#pass
