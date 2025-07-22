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
	if(player_2.animated_sprite_2d.flip_h == false):
		self.position.x = player_2.position.x + 46
		self.position.y = player_2.position.y - 22
	elif(player_2.animated_sprite_2d.flip_h == true):
		self.position.x = player_2.position.x - 45
		self.position.y = player_2.position.y - 22
		
	var attacking = player_2.attacking
	
	if(areaEntered == true && attacked == false && attacking == true):
		player_1.health -= 10
		attacked = true
		
	
	if(attacking == false):
		attacked = false


func _on_body_entered(body: Node2D) -> void:
	areaEntered = true


func _on_body_exited(body: Node2D) -> void:
	areaEntered = false
