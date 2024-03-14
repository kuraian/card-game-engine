class_name CardCollection extends Control

signal collection_added_card(collection: CardCollection, card: Card)
signal collection_removed_card(collection: CardCollection, card: Card)
signal card_hovered(card: Card)
signal card_unhovered(card: Card)
signal card_clicked(card: Card)
signal card_unclicked(card: Card)

@export var pile_position := Vector2.ZERO

@export_group("Cards")

var _cards := [] # an array of Card objects
var max_cards := 52

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
	pass # Replace with function body.

func _process(delta):
	pass
