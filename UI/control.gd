extends Control

# Main Title Screen
@onready var backGround: AnimatedSprite2D = $BackGround
@onready var title: Sprite2D = $Title
@onready var menuButtons: Sprite2D = $MenuButtons
@onready var menuB: GridContainer = $GridContainer1

# Character Select Icons
@onready var characterSelect: Sprite2D = $CharacterSelect
@onready var p1Select: GridContainer = $P1Select
@onready var p2Select: GridContainer = $P2Select
@onready var playerIcon: GridContainer = $PlayerIcon

# PlayerIcon Sprites
@onready var playerIcon1: Sprite2D = $PlayerIcon/Panel1/Sprite2D
@onready var playerIcon2: Sprite2D = $PlayerIcon/Panel2/Sprite2D

# MoveIcon Sprites
@onready var icon1: Sprite2D = $P1Select/Panel1/Sprite2D
@onready var icon2: Sprite2D = $P1Select/Panel2/Sprite2D
@onready var icon3: Sprite2D = $P1Select/Panel3/Sprite2D
@onready var icon4: Sprite2D = $P1Select/Panel4/Sprite2D
@onready var icon5: Sprite2D = $P2Select/Panel1/Sprite2D
@onready var icon6: Sprite2D = $P2Select/Panel2/Sprite2D
@onready var icon7: Sprite2D = $P2Select/Panel3/Sprite2D
@onready var icon8: Sprite2D = $P2Select/Panel4/Sprite2D

# Character Select Buttons
@onready var playerIconB: GridContainer = $PlayerIconButton
@onready var goButton: GridContainer = $GoButton
@onready var p1SelectB: GridContainer = $P1SelectButtons
@onready var p2SelectB: GridContainer = $P2SelectButtons

# Go Button Highlights
@onready var Go1H: ColorRect = $GoButton/Panel1/ColorRect
@onready var Go2H: ColorRect = $GoButton/Panel2/ColorRect

# Level Select
@onready var levelSelect: Sprite2D = $LevelSelect
@onready var levelSelectB: GridContainer = $LevelSelectButtons

# Objects not in the scene
@onready var player_1: CharacterBody2D = $"../Player1"
@onready var player_2: CharacterBody2D = $"../Player2"
@onready var camera_2d: Camera2D = $"../Camera2D"

@onready var map_1: StaticBody2D = $"../Map1"
@onready var map_2: StaticBody2D = $"../Map2"
@onready var map_3: StaticBody2D = $"../Map3"
@onready var map_4: StaticBody2D = $"../Map4"
@onready var map_5: StaticBody2D = $"../Map5"


var delay = 0
var Odelay = 0
var Rdelay = 0

var pressed1 = false
var pressed2 = false

var Ready = false
var Map = 0

var playPressed = false

var screen = 0

var ranOnce = false
var ranOnce2 = false
var ranOnce3 = false

var alreadyPressed = false

func _ready():
	set_process(true)

func _process(delta):
	if(screen != 0):
		delay = 0
		ranOnce = false
	if(screen == 0):
		delay += delta
	if(screen == 0 && !ranOnce):
		summonMenu()
		ranOnce = true
	if(screen == 0):
		summonMenuControl(delay,delta)
	elif(screen == 1):
		summonCharacterSelect()
		if(!ranOnce2):
			pressed1 = false
			pressed2 = false
			ranOnce2 = true
	if(Go1H.visible == true && Go2H.visible == true):
		Rdelay += delta
		if(Rdelay >= 2):
			Rdelay = 0
			summonLevelSelect()
			screen = 2
	else:
		Rdelay = 0
	if(Ready):
		player_1.visible = true
		player_2.visible = true
		self.visible = false
		camera_2d.position_smoothing_enabled = true
		screen = 3
		if(ranOnce3 == false):
			player_1.points = -1
			player_2.points = -1
			ranOnce3 = true
			Odelay = 0
	if(player_1.points >= 4 || player_2.points >= 4):
		Odelay += delta

		if(Odelay >= 3):
			screen = 0
			player_1.points = 0
			player_2.points = 0
			Odelay = 0
			delay = 0
			Ready = false
			camera_2d.position_smoothing_enabled = false
			camera_2d.position.x = get_viewport_rect().size.x/2
			camera_2d.position.y = get_viewport_rect().size.y/2
			ranOnce3 = false
			summonMenu()
			restart()
		if(screen != 3):
			Odelay = 0
	if(Input.is_action_pressed("Back") && screen > 0 && !alreadyPressed):
		screen -= 1
		ranOnce = false
		ranOnce2 = false
		alreadyPressed = true
	if(Input.is_action_just_released("Back")):
		alreadyPressed = false
		Go1H.visible = false
		Go2H.visible = false
	

func BGAnimation():
	backGround.play("BackGround")

func PlayPressed() -> void:
	screen = 1

# Character Select Buttons
func p_1_pressed() -> void:
	if(playerIcon1.frame == 0):
		playerIcon1.frame = 1
	elif(playerIcon1.frame == 1):
		playerIcon1.frame = 0
func p_2_pressed() -> void:
	if(playerIcon2.frame == 0):
		playerIcon2.frame = 1
	elif(playerIcon2.frame == 1):
		playerIcon2.frame = 0
func p_3_pressed() -> void:
	icon1.frame += 1
	if(icon1.frame == 19):
		icon1.frame = 0
func p_4_pressed() -> void:
	icon2.frame += 1
	if(icon2.frame == 19):
		icon2.frame = 0
func p_5_pressed() -> void:
	icon3.frame += 1
	if(icon3.frame == 19):
		icon3.frame = 0.
func p_6_pressed() -> void:
	icon4.frame += 1
	if(icon4.frame == 19):
		icon4.frame = 0
func p_7_pressed() -> void:
	icon5.frame += 1
	if(icon5.frame == 19):
		icon5.frame = 0
func p_8_pressed() -> void:
	icon6.frame += 1
	if(icon6.frame == 19):
		icon6.frame = 0
func p_9_pressed() -> void:
	icon7.frame += 1
	if(icon7.frame == 19):
		icon7.frame = 0
func p_10_pressed() -> void:
	icon8.frame += 1
	if(icon8.frame == 19):
		icon8.frame = 0

# Go Buttons
func Go1() -> void:
	if(!pressed1):
		pressed1 = true
	elif(pressed1):
		pressed1 = false
func Go2() -> void:
	if(!pressed2):
		Go2H.visible = true
		pressed2 = true
	elif(pressed2):
		Go2H.visible = false
		pressed2 = false
	pass # Replace with function body.

# Level Select Buttons
func level_Select_1_Pressed() -> void:
	Ready = true
	Map = 1
func level_Select_2_Pressed() -> void:
	Ready = true
	Map = 2
func level_Select_3_Pressed() -> void:
	Ready = true
	Map = 3
func level_Select_4_Pressed() -> void:
	Ready = true
	Map = 4
func level_Select_5_Pressed() -> void:
	Ready = true
	Map = 5
func level_Select_6_Pressed() -> void:
	Ready = true
	Map = randi_range(1,5)
	
func summonMenu():
	menuB.visible = false
	backGround.visible = true
	title.visible = true
	menuButtons.visible = true
	menuButtons.modulate.a8 = 0
	title.position.x = get_viewport_rect().size.x/2
	title.position.y = get_viewport_rect().size.y/2
	BGAnimation()
	Go1H.modulate.a8 = 200
	Go2H.modulate.a8 = 200
	player_1.position.x = get_viewport_rect().size.x/2
	player_1.position.y = get_viewport_rect().size.y/2
	characterSelect.visible = false
	levelSelect.visible = false
	levelSelectB.visible = false
	p1Select.visible = false
	p1SelectB.visible = false
	p2Select.visible = false
	p2SelectB.visible = false
	playerIcon.visible = false
	playerIconB.visible = false
	goButton.visible = false
func summonMenuControl(delay, delta):
	if(delay >= 1 && title.position.y >= 125):
		title.position.y -= 1
	if(delay >= 1 && title.position.y <= 125):
		if(menuButtons.modulate.a8 <= 250):
			menuButtons.modulate.a8 += 3
		if(menuButtons.modulate.a8 >= 250):
			menuB.visible = true
func summonCharacterSelect():
	title.visible = false
	menuButtons.visible = false
	menuB.visible = false
	levelSelect.visible = false
	levelSelectB.visible = false
	characterSelect.visible = true
	p1Select.visible = true
	p2Select.visible = true
	playerIcon.visible = true
	playerIconB.visible = true
	p1SelectB.visible = true
	p2SelectB.visible = true
	goButton.visible = true
	playPressed = true
	if(pressed1):
		Go1H.visible = true
	else:
		Go1H.visible = false
	if(pressed2):
		Go2H.visible = true
	else:
		Go2H.visible = false
func summonLevelSelect():
	levelSelect.visible = true
	levelSelectB.visible = true
	characterSelect.visible = false
	p1Select.visible = false
	p1SelectB.visible = false
	p2Select.visible = false
	p2SelectB.visible = false
	playerIcon.visible = false
	playerIconB.visible = false
	goButton.visible = false
	Go1H.visible = false
	Go2H.visible = false
func restart():
	player_1.visible = false
	player_2.visible = false
	map_1.visible = false
	map_2.visible = false
	map_3.visible = false
	map_4.visible = false
	map_5.visible = false
	Map = 0
	player_1.set_collision_mask_value(3,false)
	player_2.set_collision_mask_value(3,false)
	player_1.set_collision_mask_value(4,false)
	player_2.set_collision_mask_value(4,false)
	player_1.set_collision_mask_value(5,false)
	player_2.set_collision_mask_value(5,false)
	player_1.set_collision_mask_value(6,false)
	player_2.set_collision_mask_value(6,false)
	player_1.set_collision_mask_value(7,false)
	player_2.set_collision_mask_value(7,false)
	self.visible = true
	pressed1 = false
	pressed2 = false
