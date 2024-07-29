extends Node

@onready var num_hills = 2
@onready var slice = 10
@onready var hill_range = 100

var screensize
var terrain = Array()
var texture = preload("res://PhysicsCarGameAssets/Images/Terrain/DirtBG.png")
var bridge= preload("res://scenes/btidge.tscn")
func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	terrain = Array()
	var start_y = screensize.y * 3/4 + (-hill_range + randi() % hill_range*2)
	terrain.append(Vector2(-1000, start_y))
	add_hills()
	
	
	
func _process(delta):
	if terrain[-1].x < $player.position.x + screensize.x :
		if(randi_range(0,100)<=50):
			add_bridge()
		else:
			add_hills()
			
	
	
func add_hills():
	var hill_width = screensize.x / num_hills
	var hill_slices = hill_width / slice
	var start = terrain[-1]
	var poly = PackedVector2Array()
	for i in range(num_hills):
		var height = randi() % hill_range
		start.y -= height
		for j in range(0, hill_slices):
			var hill_point = Vector2()
			hill_point.x = start.x + j * slice + hill_width * i
			hill_point.y = start.y + height * cos(2 * PI / hill_slices * j) 
			terrain.append(hill_point)
			poly.append(hill_point)
		start.y += height
	var shape = CollisionPolygon2D.new()
	var ground = Polygon2D.new()
	$terrainColi.add_child(shape)
	poly.append(Vector2(terrain[-1].x, screensize.y+550))
	poly.append(Vector2(start.x, screensize.y+550))
	shape.polygon = poly
	ground.polygon = poly
	ground.texture = texture
	ground.z_index=1
	add_child(ground)
	
func add_bridge():
		var bridgeinst=bridge.instantiate()
		var lastPoint=terrain[-1]
		bridgeinst.position=lastPoint
		terrain.append(Vector2(lastPoint.x+3000,lastPoint.y))
		add_child(bridgeinst)

func _on_head_area_body_entered(body):
	if body.is_in_group("terrain"):
		get_tree().reload_current_scene()
