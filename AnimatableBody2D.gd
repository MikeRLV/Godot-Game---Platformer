extends AnimatableBody2D
@onready var animation_player = $AnimationPlayer
@onready var platform = $".."
@onready var counter = 0
@onready var counter_limit = 7

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
