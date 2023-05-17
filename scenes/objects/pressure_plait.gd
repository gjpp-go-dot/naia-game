extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#$plate.set_deferred('monitorable',true)
	$anima.frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


signal desparo


func _on_plate_body_entered(body):
	$anima.frame = 1
	print("pisou")
	$plate/CollisionShape2D.set_deferred('disabled',true)
	#$plate.set_deferred('monitoring',false)
	$plate.set_deferred('monitorable',false)
	
	$Timer.start()
	desparo.emit()


func _on_timer_timeout():
	$plate/CollisionShape2D.set_deferred('disabled',false)
	$plate.set_deferred('monitorable',true)
	#$plate/CollisionShape2D.set_deferred('disabled',false)
	$anima.frame = 0
