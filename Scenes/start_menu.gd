extends Control


func _ready():
	var click_files = Utils.dir_contents("res://Assets/Audio/click/")
	$Select.stream = load(click_files.pick_random())


func _on_start_btn_pressed():
	$Select.play()
	await get_tree().create_timer(.1).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_btn_pressed():
	$Select.play()
	await get_tree().create_timer(.1).timeout
	get_tree().quit()
