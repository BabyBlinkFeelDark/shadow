class_name HitBox
extends Area2D

@onready var training_maneken = owner as TrainingManeken

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func hit(value: int = 0):
	training_maneken.take_hit(value)
	$"../../VBox/Damage_l".set_text("damn, its %s " % name)
	
func chase_player():
	training_maneken.go()
	$"../../VBox/Damage_l".set_text("damn, its %s " % name)
