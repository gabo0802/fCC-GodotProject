extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var SPEED = 50

@onready var frog_anim = get_node("AnimatedSprite2D")

func _ready():
	frog_anim.play("Idle")
	
func _physics_process(delta):
	# Frog Gravity:
	velocity.y += gravity * delta
	
	player = get_node("../../Player/Player")
	if chase == true:
		if frog_anim.animation != "Death":
			frog_anim.play("Jump")
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				frog_anim.flip_h = true
				velocity.x = direction.x * SPEED
			else:
				frog_anim.flip_h = false
				velocity.x = direction.x * SPEED
	else:
		if frog_anim.animation != "Death":
			frog_anim.play("Idle")
			velocity.x = 0
			
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_death_body_entered(body):
	if body.name == "Player":
		death()
		


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 3
		death()
		
func death():
	chase = false
	Game.Gold += 5
	Utils.saveGame()
	frog_anim.play("Death")
	await frog_anim.animation_finished
	self.queue_free() #deletes the frog
