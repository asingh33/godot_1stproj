extends KinematicBody2D

const GRAVITY = 10
const SPEED = 300
const JUMP = 200
const RESISTENCE = Vector2(0, -1)
const shiftX = 19.5
const JetStream_posX = -10.5

var motion = Vector2()
var state = "Idle"

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_up"):
		motion.y = -JUMP
		#$Anime.flip_h = true
		#state = "Rise"
	
	if Input.is_action_pressed("ui_right"):
		$JetStream.position.x = JetStream_posX
		#$JetStream.rotate(-1)
		motion.x = SPEED
		$Anime.flip_h = false
		state = "Run"
	elif Input.is_action_pressed("ui_left"):
		$JetStream.position.x = JetStream_posX + shiftX
		#$JetStream.rotate(1)
		motion.x = -SPEED 
		$Anime.flip_h = true
		state = "Run"
	else:
		motion.x = 0
		state = "Idle"
	
	
	if is_on_floor():
		$JetStream.lifetime = 0.2
		#$JetStream.BLEND_MODE_MIX
		$Anime.play(state)
	elif motion.y >= 0:
		$JetStream.lifetime = 0.6
		#$JetStream.BLEND_MODE_ADD
		$Anime.play("Fall")
	elif motion.y < 0:
		#$JetStream.BLEND_MODE_ADD
		$JetStream.lifetime = 1
		$Anime.play("Rise")	
	
	#elif motion.y < 0:
		
	
	#print(motion)
	
	motion = move_and_slide(motion, RESISTENCE)
