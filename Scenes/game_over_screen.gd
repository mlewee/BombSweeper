extends Control
class_name GameOver


signal game_over


func _ready():
	var click_files = Utils.dir_contents("res://Assets/Audio/click/")
	$Select.stream = load(click_files.pick_random())


func _on_restart_btn_pressed():
	$Select.play()
	await get_tree().create_timer(.1).timeout
	get_tree().reload_current_scene()


func _on_quit_btn_pressed():
	await get_tree().create_timer(.1).timeout
	get_tree().quit()


func game_complete():
	%Label.text = "Complete!!!"
	emit_signal("game_over")
