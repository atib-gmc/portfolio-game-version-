extends CharacterBody2D
class_name Chicken

@export var speed = 20
@export var max_speed := 30.0
@export var friction := 60.0
var wander_dir: Vector2
var wander_time: float = 0.0
var health = 30

# Get the gravity from the project settings to be synced with RigidBody nodes.
func randomize_move():
	wander_dir = Vector2(randf_range( - 1, 1), randf_range( - 1, 1))
	wander_time = randf_range(1, 8)

func _physics_process(delta):
	var spawn_point = (get_tree().get_first_node_in_group("chicken_spawn_point") as Marker2D).global_position - global_position
	if wander_time > 0:
		wander_time -= delta
		velocity = velocity.move_toward(wander_dir * speed, max_speed)
		if wander_time <= 3:
			if spawn_point.length() >= 75:
				velocity = velocity.move_toward(spawn_point, speed)
			else:
				velocity = velocity.move_toward(Vector2.ZERO, friction)
	else:
		# velocity = velocity.move_toward(Vector2.ZERO, friction)
		randomize_move()
	move_and_slide()

func _process(_delta):
	if velocity.x != 0.0:
		$Sprite2D.scale.x = round(sign(velocity.x))
	if velocity != Vector2.ZERO:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")

func take_damage(dmg: Attack):
	health -= dmg.damage
	($GPUParticles2D as GPUParticles2D).emitting = true
	velocity = velocity.move_toward((dmg.attack_position - global_position) * - 70, 170)
	if health <= 0:
		queue_free()
	move_and_slide()