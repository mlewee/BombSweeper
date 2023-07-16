extends Node2D

var row = 10
var col = 10
var bombs = 15
var Tile = preload("res://tile.tscn")
var tiles


func _ready():
	for r in row:
		for c in col:
			var t = Tile.instantiate()
			t.position = Vector2(r, c) * 64
			add_child(t)
	tiles = get_children()
	set_bombs()


func set_bombs():
	var n = 0
	while n < bombs:
		var tile = tiles[randi() % len(tiles)]
		if tile.is_bomb == false:
			tile.set_bomb()
			n += 1
