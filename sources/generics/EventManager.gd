
class_name EventManager

var event_handlers = {}

func add_event_handler(event_name, handler):
	if event_name not in event_handlers:
		event_handlers[event_name] = []
	event_handlers[event_name].append(handler)

func process_event(event_name):
	if event_name in event_handlers:
		for handler in event_handlers[event_name]:
			handler.call()
