extends Control

signal play

func _ready():
	$VBoxContainer/GameOver.visible = Globals.state

func _on_play_pressed() -> void:
	play.emit()
