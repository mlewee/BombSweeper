extends Control


func _on_start_btn_pressed():
	self.hide()


func _on_quit_btn_pressed():
	get_tree().quit()
