class_name CardCollection extends Control

signal collection_added_card(collection: CardCollection, card: Card)
signal collection_removed_card(collection: CardCollection, card: Card)

@export var card_scene : PackedScene
@export var collection_name := "placeholder"

var _cards := [] # an array of Card objects

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
	pass
	
func _process(delta):
	pass
