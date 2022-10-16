extends Node

var isPortuguese= false
var isPaused = false
var generalVolume = 100
var musicVolume = 100
var sfxVolume = 100

func controlMusic(maxDb : float, minDb : float):
	var  v = generalVolume * musicVolume / 100
	var db = v/100 * (maxDb - minDb)  + minDb
	return db
	
func controlSFX(maxDb : float, minDb : float):
	var  v = generalVolume * sfxVolume / 100
	var db = v/100 * (maxDb - minDb)  + minDb
	return db
