extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_body_entered(_body):
	get_tree().call_deferred("reload_current_scene")