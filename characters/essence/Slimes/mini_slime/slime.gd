extends CharacterBody2D
@onready var player = $"../player"
@onready var anima_slime = $AnimatedSprite2D
const speed = 100
var is_player: bool
var can_attack: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity += get_gravity() * delta
	
	if is_player:
		global_position.x = move_toward(global_position.x, player.position.x, 0.2)
		anima_slime.play("walk")
	elif can_attack:
		velocity=Vector2.ZERO
		anima_slime.play("attack")
		
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	is_player=true
	print("yup")


func _on_attack_area_body_entered(body: Node2D) -> void:
	print("attack")

	can_attack = true


func _on_attack_area_body_exited(body: Node2D) -> void:
	can_attack = false
