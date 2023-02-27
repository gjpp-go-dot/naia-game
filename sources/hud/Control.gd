extends Control


const MAX_LIFE = 3
var current_life = MAX_LIFE

func apply_damage(damage_value):
	current_life -= damage_value
	if(current_life <= 0):
		return {
			"death": true
		}
	return {
		"death": false
	}

func apply_heal(heal_value):
	current_life += heal_value
	if(current_life > 3):
		current_life = 3

func _process(delta):
	$LifeHud.frame = MAX_LIFE - current_life
