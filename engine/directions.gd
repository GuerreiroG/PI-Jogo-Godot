extends Node

const center	= Vector2.ZERO
const left		= Vector2.LEFT
const right		= Vector2.RIGHT
const up		= Vector2.UP
const down		= Vector2.DOWN

func rand():
	var d = randi() % 4 + 1
	match d:
		1:
			return left
		2:
			return right
		3:
			return up
		4: 
			return down 
