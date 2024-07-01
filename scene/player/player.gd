extends CharacterBody2D

const SPEED = 80
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@export var max_speed := 200.0
@export var acceleration := 500.0
@export var friction := 300.0
var vector: Vector2 = Vector2.ZERO
var attack: bool
var dir = "front"
var status = "idle"

func _ready():
	pass

func _process(_delta):
	vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if attack:
		velocity = Vector2.ZERO
		return
	velocity = vector * SPEED
	# print(vector == Vector2(-0.707107, 0.707107), vector)
	match vector.round():
		Vector2(0, -1):
			dir = "top"
			status = "walk"
		Vector2( - 1, -1):
			dir = "top"
			status = "walk"
		Vector2(1, -1):
			dir = "top"
			status = "walk"
		Vector2(0, 1):
			dir = "front"
			status = "walk"
		Vector2(1, 1):
			dir = "front"
			status = "walk"
		Vector2( - 1, 1):
			dir = "front"
			status = "walk"
		Vector2(1, 0):
			dir = "right"
			status = "walk"
		Vector2( - 1, 0):
			dir = "left"
			status = "walk"
		_:
			status = "idle"
			dir = dir
	if Input.is_action_just_pressed("attack"):
		set_attack(true)
	move_and_slide()
	pass

func _physics_process(_delta):
	if attack:
		anim_player.play("attack_" + str(dir))
	else:
		anim_player.play(str(status) + "_" + str(dir))

func set_attack(value: bool=false):
	attack = value

func _on_hit_box_body_entered(body):
	if body.has_method("take_damage"):
		var attack_dmg = Attack.new()
		attack_dmg.damage = 12
		attack_dmg.attack_position = global_position
		attack_dmg.knockback_force = 40
		body.take_damage(attack_dmg)
