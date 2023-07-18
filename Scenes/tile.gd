extends Node2D
class_name Tile


var is_cover = true
var flagged = false
var is_bomb = false
 

func _ready():
	var cover_textures = ["res://Assets/Arts/boxCrate_double.png", "res://Assets/Arts/boxCrate_single.png"]
	$Cover.set_texture(load(cover_textures.pick_random()))
	var flag_textures = ["res://Assets/Arts/flagBlue1.png", "res://Assets/Arts/flagBlue2.png"]
	$Flag.set_texture(load(flag_textures.pick_random()))


func set_bomb():
	is_bomb = true
	$Bomb.show()
	$Label.hide() 


func uncover(play_sound=true):
	if not flagged:
		$Cover.hide()
		if is_bomb:
			$Back.modulate = Color("#b56267")
			get_parent().game_over()
		else:
			if is_cover:
				get_parent().check_boxes()
				if play_sound:
					$Uncover.play()
			is_cover = false
			var count_surrounds = 0
			for tile in get_surrounds():
				if tile.is_bomb:
					count_surrounds += 1
			if count_surrounds > 0:
				$Label.text = str(count_surrounds)
			else:
				for tile in get_surrounds():
					if tile.is_cover:
						tile.uncover(false)


func force_uncover():
	$Cover.hide()


func get_surrounds():
	var surrounds = []
	var offsets = [
		(Vector2.UP + Vector2.LEFT) * 64,  # ↖
		Vector2.UP * 64,  # ⬆
		(Vector2.UP + Vector2.RIGHT) * 64,  # ↗
		Vector2.RIGHT * 64,  # ➡
		(Vector2.DOWN + Vector2.RIGHT) * 64,  # ↘
		Vector2.DOWN * 64,  # ⬇
		(Vector2.DOWN + Vector2.LEFT) * 64,  # ↙
		Vector2.LEFT * 64,  # ⬅
	]
	for offset in offsets:
		for tile in get_parent().tiles:
			if tile.position == position + offset:
				surrounds.append(tile)
	return surrounds


func toggle_flag():
	if is_cover:
		if flagged:
			flagged = false
			$Flag.hide()
			get_parent().set_available_flags()
		else:
			if get_parent().flags > 0:
				flagged = true
				$Flag.show()
				get_parent().set_available_flags(false)


func _on_control_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("Left_Click"):
			uncover()
		if event.is_action_pressed("Right_Click"):
			toggle_flag()
