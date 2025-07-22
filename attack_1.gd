extends Area2D

@onready var player_1: CharacterBody2D = $"../Player1"
@onready var player_2: CharacterBody2D = $"../Player2"

var attacking = false
var attacked = false

var areaEntered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(player_1.animated_sprite_2d.flip_h == false):
		self.position.x = player_1.position.x + 38
		self.position.y = player_1.position.y - 10
	elif(player_1.animated_sprite_2d.flip_h == true):
		self.position.x = player_1.position.x - 53
		self.position.y = player_1.position.y - 10
		
	var attacking = player_1.attacking
	
	if(areaEntered == true && attacked == false && attacking == true):
		player_2.health -= 10
		attacked = true
		
	
	if(attacking == false):
		attacked = false


func _on_body_entered(body: Node2D) -> void:
	areaEntered = true
	

func _on_body_exited(body: Node2D) -> void:
	areaEntered = false
