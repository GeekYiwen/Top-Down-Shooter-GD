extends KinematicBody2D

var movespeed = 500
var bulletspeed = 2000
var bulletScene = preload("res://Bullet.tscn")

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		fire()
	
func fire():
	var bulletInstance = bulletScene.instance()
	bulletInstance.position = get_global_position()
	bulletInstance.rotation_degrees = rotation_degrees
	bulletInstance.apply_impulse(Vector2(), Vector2(bulletspeed, 0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bulletInstance)

func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		kill()

func kill():
	pass
	# get_tree().reload_current_scene()



