extends Control


func _on_restart_btn_pressed():
	$Select.play()
	await get_tree().create_timer(.1).timeout
	get_tree().reload_current_scene()


func _on_quit_btn_pressed():
	$Select.play()
	await get_tree().create_timer(.1).timeout
	get_tree().quit()
