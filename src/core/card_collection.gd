@tool
class_name CardCollection extends Control

signal collection_clicked(collection: CardCollection)
signal collection_unclicked(collection: CardCollection)
signal collection_hovered(collection: CardCollection)
signal collection_unhovered(collection: CardCollection)
signal collection_added_card(collection: CardCollection, card: Card)
signal collection_removed_card(collection: CardCollection, card: Card)

@export var collection_name := "collection name"
@export var max_cards := 10
@export var interactable := true

var _cards := [] # an array of Card objects modeled as stack, last = top
var clicked := false
var hovered := false

func _to_string():
	return collection_name

func add_card(card: Card):
	_cards.push_back(card)
	emit_signal("collection_added_card", self, card)

func remove_card(card: Card):
	_cards.erase(card)
	emit_signal("collection_removed_card", self, card)

func get_duplicate():
	return _cards.duplicate()

func get_card_by_index(index: int):
	return _cards[index]

func get_collection_size():
	return _cards.size()

func shuffle():
	_cards.shuffle()

func _ready():
	mouse_entered.connect(_on_mouse_enter)
	mouse_exited.connect(_on_mouse_exit)
	gui_input.connect(_on_gui_input)

func _on_mouse_enter():
	if interactable:
		hovered = true
		emit_signal("collection_hovered", self)

func _on_mouse_exit():
	if clicked:
		return
	if hovered:
		hovered = false
		emit_signal("collection_unhovered", self)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if interactable:
				clicked = true
				hovered = false
				emit_signal("collection_clicked", self)
		else:
			if clicked:
				clicked = false
				emit_signal("collection_unclicked", self)

func _process(delta):
	pass
