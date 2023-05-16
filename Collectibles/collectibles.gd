extends Node2D

var Cherry = preload("res://Collectibles/Cherry.tscn")



func _on_timer_timeout():
	var cherryTemp = Cherry.instantiate()
	
	var rng = RandomNumberGenerator.new()
	var ranint = rng.randi_range(10, 500)
	
	cherryTemp.position = Vector2(ranint ,-5)
	add_child(cherryTemp)
