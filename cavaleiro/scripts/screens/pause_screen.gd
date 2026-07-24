extends Control

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/screens/title_screen.tscn")

func _on_continuar_pressed() -> void:
	visible = false
	get_tree().paused = false
