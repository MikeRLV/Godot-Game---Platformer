extends Sprite2D
@onready var gpu_particles_2d = $"../GPUParticles2D"
@onready var collision_shape_2d = $"../CollisionShape2D"
@onready var area_2d = $"../Area2D"
var spawn_position = Vector2. ZERO

@export var TEXTURE_VARIATIONS_ARRAY: Array = [
	preload("res://Assets/1 Tiles/IndustrialTile_36.png"),
	preload("res://Assets/1 Tiles/IndustrialTile_62.png"),
	preload("res://Assets/1 Tiles/IndustrialTile_71.png")]

var texture_id : int = randi() % TEXTURE_VARIATIONS_ARRAY.size()
var chosen_texture: Texture = TEXTURE_VARIATIONS_ARRAY[texture_id]
var time = 1
@onready var timer = $"../Timer"

func _ready():
	set_process(false)
	variate_texture()
	variate_particles()
	pass # Replace with function body.

func variate_particles():
	gpu_particles_2d.set_texture(texture)
#thank you dotblank for providing me with this information

func variate_texture():
	if TEXTURE_VARIATIONS_ARRAY.size() >=0:
		texture = chosen_texture

func _process(_delta):
	time += 1
	position += Vector2(0, sin(time) * 2)


func _on_area_2d_body_entered(body):
	if body.name == 'Player':
		set_process(true)
		timer.start(1)


func _on_timer_timeout():
	if is_processing():
		set_process(false)
		gpu_particles_2d.emitting = true
		area_2d.queue_free()
		collision_shape_2d.queue_free()
		queue_free()
		timer.start(1.2)
	else:
		queue_free()


func _on_area_2d_body_exited(body):
	if body.name == 'Player':
		position = spawn_position
		set_process(false)
		timer.stop()
