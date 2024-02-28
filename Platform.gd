extends AnimatedSprite2D
@onready var emp_range = $EMP_Range
@onready var animatable_body_2d = $AnimatableBody2D
@onready var collision_shape_2d = $AnimatableBody2D/CollisionShape2D
@onready var animation_player = $AnimatableBody2D/AnimationPlayer
var character : CharacterBody2D
@export var spring = -800
@onready var timer = $Timer
@onready var timer_on = false


func _ready():
	
	
	start_platform()
	timer_is_on_check()
	animation_player.play("platform_idle")
	set_process(false)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	animation_player.play("platform_open")
	pass
	
func handleusing():
	print("buttong is held")

func state_input(event : InputEvent):
	if(event.is_action_pressed("Use")):
		timer.start(1)
		set_process(true)
		print("Pocket EMP'D")


func start_platform():
		timer.start(1)
		set_process(true)
	
func timer_is_on_check():
	if timer.time_left != 0:
		timer_on = true

func _on_area_2d_body_entered(body):
	if body.name == 'Player':
		body.velocity.y = spring
		print("launch!")


func _on_timer_timeout():
	if is_processing():
		set_process(false)
		animation_player.play("platform_close")
	


func _on_emp_range_body_entered(body):
	if body.name == 'Player' && Input.is_action_pressed("Use"):
		print("EMP!")
		start_platform()
