extends Node2D

@onready var final: Label = $Labels/Final
@onready var objetivo: Label = $Labels/Objetivo
@onready var moedas: Label = $Player/HUD/Moedas
@onready var pontos: Label = $Player/HUD/Pontos
@onready var level: Label = $Player/HUD/Level
var ganhou = false
@onready var pause_screen: Control = $Player/PauseScreen

func _ready() -> void:
	$Player/Esquerda.visible = GameManager.mobile
	$Player/Direita.visible = GameManager.mobile
	$Player/Pular.visible = GameManager.mobile

	await get_tree().process_frame
	
	var total = get_tree().get_nodes_in_group("coin").size()
	GameManager.reset_level(total)
	objetivo.text = "Colete " + str(GameManager.max) + " moedas!"
	level.text = "Nível " + str(GameManager.level)

func _process(_delta: float) -> void:
	_update_labels()
	if GameManager.moedas == GameManager.max and not ganhou: 
		GameManager.win()
		ganhou = true
		$Player.win = true

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func _update_labels() -> void:
	final.text = "Você coletou " + str(GameManager.moedas) + " moedas!"
	moedas.text = str(GameManager.moedas)
	pontos.text = str(GameManager.score)

func _on_pause_pressed() -> void:
	toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	pause_screen.visible = get_tree().paused
