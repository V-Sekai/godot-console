
extends 'res://addons/quentincaffeino/array-utils/src/QueueCollection.gd'

var _console

# @param  int  maxLength
func _init(console, maxLength):
	self._console = console
	self.set_max_length(maxLength)


# @returns  History
func print_all():
	var i = 1
	for command in self.get_value_iterator():
		self._console.write_line(\
			'[b]' + str(i) + '.[/b] [color=#ffff66][url=' + \
			command + ']' + command + '[/url][/color]')
		i += 1

	return self
