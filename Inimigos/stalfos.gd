extends "res://engine/entity.gd"

const DAMAGE = 1
var duracao_tempo_movimento = 30
var tempo_movimento = 0

func _ready():
	$anim.play("default")
	movedir = dir.rand()

func _physics_process(_delta):
	loop_dano()
	movement_loop()
	if tempo_movimento > 0:
		tempo_movimento -= 1
	if tempo_movimento == 0 or is_on_wall():
		movedir = dir.rand()
		tempo_movimento = duracao_tempo_movimento
