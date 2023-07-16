extends Node2D

@onready var gameover = $UILayer/GameOverScreen


var row = 10
var col = 10
var bombs = 15
var Tile = preload("res://tile.tscn")
var tiles


func _ready():
	gameover.hide()
	for r in row:
		for c in col:
			var t = Tile.instantiate()
			t.position = Vector2(r, c) * 64
			add_child(t)
	tiles = get_tree().get_nodes_in_group("Tile")
	set_bombs()
	

func get_tiles(tile):
	print(tile)
	return tile


func set_bombs():
	var n = 0
	while n < bombs:
		var tile = tiles[randi() % len(tiles)]
		if tile.is_bomb == false:
			tile.set_bomb()
			n += 1
