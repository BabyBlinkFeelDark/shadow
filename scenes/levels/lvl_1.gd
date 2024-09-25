extends Node2D

@onready var MANEKEN = preload("res://characters/essence/NightBorme/night_borne.tscn")
var frag_couner : int = 0

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	while (frag_couner<3):
		var training_maneken = MANEKEN.instantiate()
		training_maneken.global_position = (Vector2(randi_range(100,500),520))
		add_child(training_maneken)
		frag_couner+=1

	pass
