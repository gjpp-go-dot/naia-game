extends ProgressBar

var progress_bar_tween = null

func start_bounce():
	value = 0
	if progress_bar_tween:
		progress_bar_tween.kill()
	progress_bar_tween = create_tween()
	progress_bar_tween.tween_property(self, "value", 100, 1)
	progress_bar_tween.tween_property(self, "value", 0, 1)
	progress_bar_tween.set_loops()

func stop_bounce():
	progress_bar_tween.stop()
	progress_bar_tween.kill()