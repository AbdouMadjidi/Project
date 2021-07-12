extends Control




func _on_Start_Buttom_pressed():
	get_tree().change_scene("res://Game.tscn")


func _on_MP_Butoom_pressed():
	get_tree().change_scene("res://Network_setup.tscn")


func _on_Quit_pressed():
	get_tree().quit()
