extends Node2D


@onready var gameoverscreen = $UILayer/GameOverScreen


var Tile = preload("res://Scenes/tile.tscn")
var tiles = []

var row = 10
var col = 10
var bombs = 15
var flags = 0
var total_boxes = 0
var opened_boxes = 0
 

func _ready():
	flags = bombs
	total_boxes = (row * col) - bombs
	
	gameoverscreen.hide()
	for r in row:
		for c in col:
			var t = Tile.instantiate()
			t.position = Vector2(r, c) * 64
			add_child(t)
	tiles = get_tree().get_nodes_in_group("Tile")
	set_bombs()


func set_bombs():
	var n = 0
	while n < bombs:
		var tile = tiles[randi() % len(tiles)]
		if tile.is_bomb == false:
			tile.set_bomb()
			n += 1


func set_available_flags(add = true):
	if add:
		flags += 1
	else:
		flags -= 1


func check_boxes():
	opened_boxes += 1
	if total_boxes == opened_boxes:
		gameoverscreen.gamecomplete()


func gameover(defeat=true):
	if defeat:
		$Explosion.play()
		for tile in tiles:
			if tile.is_bomb:
				tile.force_uncover()
	gameoverscreen.show()


func _on_game_over_screen_game_over():
	gameover(false)
