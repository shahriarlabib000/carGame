extends RigidBody2D

var wheels=[]
var speed=60000
var maxSpeed=60
# Called when the node enters the scene tree for the first time.
func _ready():
	wheels= get_tree().get_nodes_in_group("wheel")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		for wheel in wheels:
			if wheel.angular_velocity < maxSpeed:
				wheel.apply_torque_impulse(speed * delta * 60)
	if Input.is_action_pressed("ui_left"):
		for wheel in wheels:
			if wheel.angular_velocity > -maxSpeed:
				wheel.apply_torque_impulse(-(speed * delta * 60))
	if Input.is_action_pressed("ui_redo"):
		get_tree().reload_current_scene()
		
