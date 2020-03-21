extends KinematicBody2D

export(String) var TYPE = "INIMIGO"
var movedir = dir.center
var knockdir = dir.center
var spritedir = "baixo"

var hitstun = 0
var health = 1
var texture_default = null
var texture_hurt = null

func _ready():
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace(".png","_hurt.png"))

export(int) var velocidade = 0

func movement_loop():
	var motion
	if hitstun > 0:
		motion = knockdir.normalized() * 125
	else:
		motion = movedir.normalized() * velocidade
	move_and_slide(motion, Vector2.ZERO)

func loop_spritedir():
	match movedir:
		dir.left:
			spritedir = "esquerda" 
		dir.right:
			spritedir = "direita" 
		dir.up:
			spritedir = "cima" 
		dir.down:
			spritedir = "baixo" 
			
func mudar_anim(animation):
	var nova_anim = str(animation,spritedir)
	if $anim.current_animation != nova_anim:
		$anim.play(nova_anim) 

func loop_dano():
	if hitstun > 0:
		hitstun -= 1
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if  hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin

func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(newitem.get_name(), self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		newitem.queue_free()
