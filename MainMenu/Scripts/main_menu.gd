extends Control




func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	# Release mouse when pressing ESC
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	# Recapture mouse when clicking anywhere
	if event is InputEventMouseButton and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_play_1_button_pressed() -> void:
	SceneManager.change_scene("res://Game1/Scenes/Platformer.tscn", {
		"pattern": "circle",
		"color": Color("14f5fcff")
		
	})


func _on_play_4_button_pressed() -> void:
	var path_to_exe= ProjectSettings.globalize_path("res://Games/Adventurer/Adventurer.exe")
	var arguments = []
	var result = OS.create_process(path_to_exe, arguments)
	if result != -1:
		await get_tree().create_timer(5.0).timeout


func _on_play_3_button_pressed() -> void:
	var path_to_exe= ProjectSettings.globalize_path("res://Games/Ghost/Ghost.exe")
	var arguments = []
	var result = OS.create_process(path_to_exe, arguments)
	if result != -1:
		await get_tree().create_timer(5.0).timeout


func _on_play_2_button_pressed() -> void:
	var path_to_exe= ProjectSettings.globalize_path("res://Games/Assignment2/Assignment2.exe")
	var arguments = []
	var result = OS.create_process(path_to_exe, arguments)
	if result != -1:
		await get_tree().create_timer(5.0).timeout


func _on_button_pressed() -> void:
	get_tree().quit()
