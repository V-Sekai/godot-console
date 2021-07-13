
extends RefCounted

const CallbackBuilder = preload("res://addons/quentincaffeino/callback/src/CallbackBuilder.gd")


# @var  Callback
var _object_get_value_cb

# @var  Callback
var _object_get_length_cb

# @var  int
var _iteration_current_index = 0

# @var  int
var _length :
	set = _set_readonly,
	get = length


# @param  Reference  target
# @param  String     get_value_field
# @param  String     get_length_field
func _init(target, get_value_field = "get", get_length_field = "size"):
	_object_get_value_cb = CallbackBuilder.new(target).set_name(get_value_field).build()
	_object_get_length_cb = CallbackBuilder.new(target).set_name(get_length_field).build()


# @returns  int
func length():
	return self._object_get_length_cb.call()


# @param    int  index
# @returns  Variant
func _get(index):
	return self._object_get_value_cb.call([index])


# Sets the internal iterator to the first element in the collection and returns this element.
# @returns  Variant|null
func first() -> Variant:
	if self._length:
		self._iteration_current_index = 0
		return self._get(self._iteration_current_index)

	return null


# Sets the internal iterator to the last element in the collection and returns this element.
# @returns  Variant|null
func last() -> Variant:
	if self._length:
		self._iteration_current_index = self._length - 1
		return self._get(self._iteration_current_index)

	return null


# Gets the current key/index at the current internal iterator position.
# @returns  Variant|null
func key() -> Variant:
	if self._length:
		return self._iteration_current_index

	return null


# Moves the internal iterator position to the next element and returns this element.
# @returns  Variant|null
func next() -> Variant:
	if self._length and self._iteration_current_index < self._length - 1:
		self._iteration_current_index += 1
		return self._get(self._iteration_current_index)

	return null


# Moves the internal iterator position to the previous element and returns this element.
# @returns  Variant|null
func previous() -> Variant:
	if self._length and self._iteration_current_index > 0:
		self._iteration_current_index -= 1
		return self._get(self._iteration_current_index)

	return null


# Gets the element of the collection at the current internal iterator position.
# @returns  Variant|null
func current() -> Variant:
	if self._length:
		return self._get(self._iteration_current_index)

	return null


# @override  _iter_init(?)
# @returns   bool
func _iter_init(arg) -> bool:
	self._iteration_current_index = 0
	return self._iteration_current_index < self._length


# @override  _iter_next(?)
# @returns   bool
func _iter_next(arg) -> bool:
	self._iteration_current_index += 1
	return self._iteration_current_index < self._length


# @override  _iter_get(?)
# @returns   Variant
func _iter_get(arg: Variant = null) -> Variant:
	return self._get(self._iteration_current_index)


# @returns  void
func _set_readonly(value):
	print("qc/iterator: Iterator: Attempted to set readonly value, ignoring.")
