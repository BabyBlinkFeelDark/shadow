class_name TrainingManeken
extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
@onready var animation = $AnimationPlayer#$AnimationPlayer
@onready var animation_sprite = $AnimatedSprite2D#$AnimatedSprite2D
@onready var hitboxes = $HitBoxes
@onready var chasearea = $ChaseArea
@onready var front = $ChaseArea/playerBack/CollisionPolygon2D
@onready var back = $ChaseArea/playerFront/CollisionPolygon2D
@onready var player = $"../player"
var is_player:bool
var is_back:bool
var is_front:bool
var is_alive:bool = true
var health: int = 100

func _ready() -> void:
	is_player=false
func _physics_process(delta: float) -> void:


	if health<0:
		$VBox/heal_l.set_text('0')
		is_alive = false
		animation.play("death")
		await animation.animation_finished
		queue_free()
	
	$VBox/heal_l.set_text(str(health))
	if not is_on_floor():
		velocity += get_gravity() * delta
	go()
	#animation.play("idle")
	move_and_slide()

func take_hit(value: int):
	back.disabled = true
	front.disabled= true
	health-=value
	animation.play("take_hit")
	await animation.animation_finished
	$VBox/value_l.set_text("Attack power: %s" % value)
	$Timer.start()
	

func go():
	print("is_player ", str(is_player))
	print("front.disabled ", str(front.disabled))
	$Timer.start()
	var direction : int
	if global_position.x - player.global_position.x>0:
		direction = 1
		animation_sprite.flip_h=true
	else:
		direction = -1
		animation_sprite.flip_h=false
	
	if not animation_sprite.is_flipped_h() and is_back:
		animation_sprite.flip_h=false

	elif animation_sprite.is_flipped_h() and is_back:
		animation_sprite.flip_h=true
		

	if animation_sprite.is_flipped_h():
		chasearea.set_scale(Vector2(1,1))
		back.disabled = false
		front.disabled= false
		
	else:
		chasearea.set_scale(Vector2(-1,1))
		back.disabled = false
		front.disabled= false
		
		

		
		
		
	if is_player and (global_position.x - player.position.x>0):
		global_position.x = move_toward(global_position.x, player.position.x+20, 0.2)
		animation.play("walk")
	elif is_player and (global_position.x - player.position.x<0) and  player.anim.is_flipped_h():
		global_position.x = move_toward(global_position.x, player.position.x-20, 0.2)
		animation.play("walk")
	elif is_player and (global_position.x - player.position.x<0) and not player.anim.is_flipped_h():
		global_position.x = move_toward(global_position.x, player.position.x-10, 0.2)
		animation.play("walk")
	if not is_player:
		animation.play("idle")

	pass

func _on_timer_timeout() -> void:
	$VBox/Damage_l.set_text("")
	$VBox/value_l.set_text("")


func _on_player_back_body_entered(body: Node2D) -> void:
	is_player=true
	is_back=true
	is_front = false
	print(is_player)


func _on_player_back_body_exited(body: Node2D) -> void:
	is_player=false


func _on_player_front_body_entered(body: Node2D) -> void:
	is_player=true
	is_front = true
	is_back=false
	print(is_player)


func _on_player_front_body_exited(body: Node2D) -> void:
	is_player=false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation.play("walk")
