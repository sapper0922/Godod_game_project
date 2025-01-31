extends Node2D

# Platforms
@onready var map1: StaticBody2D = $Map1
@onready var map2: StaticBody2D = $Map2
@onready var map3: StaticBody2D = $Map3
@onready var map5: StaticBody2D = $Map5

# Camera
@onready var camera_2d: Camera2D = $Camera2D
@onready var player_1: CharacterBody2D = $Player1
@onready var player_2: CharacterBody2D = $Player2

# UI
@onready var control: Control = $Control

var distance = 0
var zoom = 0
var maxZoom = 0.56

func _ready() -> void:
	#RenderingServer.set_default_clear_color(Color.BLACK)
	camera_2d.position.x = get_viewport_rect().size.x/2
	camera_2d.position.y = get_viewport_rect().size.y/2
	map1.visible = false
	map2.visible = false
	for i in range(8):
		player_1.set_collision_mask_value(i,false)
		player_2.set_collision_mask_value(i,false)
	set_process(true)

func _process(delta: float) -> void:
	if(player_1.visible == true && player_2.visible == true):
		distance = abs(player_1.position.x - player_2.position.x)/3
		if(player_1.points > 3):
			camera_2d.position.x = player_1.position.x
			camera_2d.position.y = player_1.position.y
			player_2.position.x = 5000
		elif(player_2.points > 3):
			camera_2d.position.x = player_2.position.x
			camera_2d.position.y = player_2.position.y
			player_1.position.x = 5000
		elif(player_1.points <= 3 && player_2.points <= 3):
			camera_2d.position.x = (player_1.position.x + player_2.position.x)/2
			camera_2d.position.y = (player_2.position.y + player_1.position.y)/2
		if(distance >= 200):
			if(player_1.points <= 3 && player_2.points <= 3):
				zoom = 200/distance
				camera_2d.zoom = Vector2(zoom,zoom)
			if(zoom <= maxZoom):
				if(player_1.points <= 3 && player_2.points <= 3):
					camera_2d.zoom = Vector2(maxZoom,maxZoom)
		elif(distance < 200):
			camera_2d.zoom = Vector2(1,1)
		
	if(control.Map == 1):
		map1.visible = true
		
		if(player_1.velocity.y < 0):
			player_1.set_collision_mask_value(3,false)
			
		else:
			player_1.set_collision_mask_value(3,true)
		
		if(player_2.velocity.y < 0):
			player_2.set_collision_mask_value(3,false)
			
		else:
			player_2.set_collision_mask_value(3,true)
		
	elif(control.Map == 2):
		map2.visible = true
		
		if(player_1.velocity.y < 0):
			player_1.set_collision_mask_value(4,false)
			
		else:
			player_1.set_collision_mask_value(4,true)
		
		if(player_2.velocity.y < 0):
			player_2.set_collision_mask_value(4,false)
			
		else:
			player_2.set_collision_mask_value(4,true)
			
	elif(control.Map == 3): 
		map3.visible = true
		
		if(player_1.velocity.y < 0):
			player_1.set_collision_mask_value(5,false)
			
		else:
			player_1.set_collision_mask_value(5,true)
		
		if(player_2.velocity.y < 0):
			player_2.set_collision_mask_value(5,false)
			
		else:
			player_2.set_collision_mask_value(5,true)
			
	elif(control.Map == 4):
		pass
	elif(control.Map == 5):
		map5.visible = true
		
		if(player_1.velocity.y < 0):
			player_1.set_collision_mask_value(7,false)
			
		else:
			player_1.set_collision_mask_value(7,true)
		
		if(player_2.velocity.y < 0):
			player_2.set_collision_mask_value(7,false)
			
		else:
			player_2.set_collision_mask_value(7,true)
