extends Node

class_name State

@export var can_move : bool = true
@export var has_doubled_jumped : bool = false
var character : CharacterBody2D
var next_state : State
var playback : AnimationNodeStateMachinePlayback
var has_double_jumped = false

func state_process(_delta):
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

func idle_check():
	pass

func wall_hit():
	pass

func double_jump():
	pass

#func reset_timer():
	#pass
