extends "res://engine/entity.gd"

var state = "default"

func _physics_process(_delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()

func state_default():
	controls_loop()
	loop_spritedir()
	loop_dano()
	movement_loop()
	
	if movedir == dir.center:
		mudar_anim("idle")
	elif is_on_wall():
		mudar_anim("push")
	else:
		mudar_anim("andar")
		
	if Input.is_action_just_pressed("a"):
		use_item(preload("res://items/espada.tscn"))

func state_swing():
	mudar_anim("idle")
	movement_loop()
	loop_dano()
	movedir = dir.center

func controls_loop():
	var LEFT 	= Input.is_action_pressed("ui_left")
	var RIGHT 	= Input.is_action_pressed("ui_right")
	var UP 		= Input.is_action_pressed("ui_up")
	var DOWN 	= Input.is_action_pressed("ui_down")
	 
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
