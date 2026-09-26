extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply()

func sett_texture(tex: Texture2D):
	texture = tex
	apply()
	
func apply():
	if not texture:
		return
	var texsize = texture.get_size()
	if texsize.x == 0 or texsize.y == 0:
		return
	var s =  min(200 / texsize.x, 200 / texsize.y)
	scale = Vector2(s,s)
	
