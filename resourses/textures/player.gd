extends CharacterBody2D


enum {
	WALK,
	DEATH,
	JUMP,
	FALL,
	CLIMB,
	ATTACK,
	DASH,
	DAMAGE,
	SLIDE
}

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
@onready var anim = get_node("AnimatedSprite2D")
@onready var anim_player = get_node("AnimationPlayer")
var health = 100
var money = 0
var state = WALK
var DASH_VEL = 1
var canDash = true
var canClipb = true
var inJump = false
var colddown_dash = 0.5
var colddown_climp = 1
var itsDamage = false
var itsWall=false
const JUMP_q = 3
var jump_count
var alive=true




var state: int = 0:
	set(value):
		state=value
		match state:
			WALK:
				walk_state()
			JUMP:
				jump_state()
			FALL:
				fall_state()
			CLIMB:
				climb_state()
			ATTACK:
				pass
			DEATH:
				death_state()
			DASH:
				dash_state()
			DAMAGE:
				damage_state()
			SLIDE:
				pass
	
func _process(delta: float) -> void:
	print(state)
	print(Input.get_axis("left", "right"))
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	
	move_and_slide()
	
func walk_state():
	#Выбор направления движения и умножение на скорость персонажа
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED 
		if velocity.y == 0:
			anim_player.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim_player.play('idle')
	
	#Мониторить направление игрока и отражать в случае смены направления
	if direction == -1:
		anim.flip_h=true
	elif direction == 1: 
		anim.flip_h=false
		
	#Переход в состояние
	if alive == true:
		if Input.is_action_just_pressed("jump") and jump_count<JUMP_q:
			state = JUMP
		if Input.is_action_just_pressed("dash") and canDash == true:
			state = DASH
		if not is_on_floor():
			state = FALL
		if canClipb==true and Input.is_action_pressed("jump") and itsWall==true and not is_on_floor():
			state = CLIMB
		#DAMAGE
		if  is_on_floor() and itsWall==true:
			state = SLIDE
	else:	
		state=DEATH		
			
			
			
			
			
			
func jump_state():
	#Переход в состояние
	if alive == true:

		if Input.is_action_just_pressed("dash") and canDash == true:
			state = DASH
		if not is_on_floor():
			state = FALL
		if canClipb==true and Input.is_action_pressed("jump") and itsWall==true and not is_on_floor():
			state = CLIMB
		#DAMAGE
		if  is_on_floor() and itsWall==true:
			state = SLIDE
	else:	
		state=DEATH		
	
	
func fall_state():
	state = WALK
	pass
func climb_state():
	state=WALK
	pass
func death_state():
	state=WALK
	pass
func dash_state():
	state=WALK
	pass
func damage_state():
	state=WALK
	pass
