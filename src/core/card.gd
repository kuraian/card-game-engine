@tool
class_name	Card extends Control

signal card_clicked(card: Card)
signal card_unclicked(card: Card)
signal card_hovered(card: Card)
signal card_unhovered(card: Card)
signal collection_entered(card: Card, collection: CardCollection)
signal collection_exited(card: Card, collection: CardCollection)

@onready var base = $Base
@onready var icon = $Icon

@export var data : CardData
@export var base_texture : String
@export var icon_texture : String
@export var interactable := true
@export var draggable := true
@export var hover_distance := 20

var target_position := Vector2.ZERO
var clicked := false
var hovered := false

func set_ability(interact=true, drag=true):
	interactable=interact
	draggable=drag

func _ready():
	mouse_entered.connect(_on_mouse_enter)
	mouse_exited.connect(_on_mouse_exit)
	gui_input.connect(_on_gui_input)

	custom_minimum_size = base.get_size()
	mouse_filter = Control.MOUSE_FILTER_PASS

func _on_mouse_enter():
	print("entered")
	if interactable:
		hovered = true
		target_position.y -= hover_distance
		emit_signal("card_hovered", self)

func _on_mouse_exit():
	if clicked:
		return
	if hovered:
		hovered = false
		target_position.y += hover_distance
		emit_signal("card_unhovered", self)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if interactable:
				clicked = true
				hovered = false
				emit_signal("card_clicked", self)
		else:
			if clicked:
				clicked = false
				emit_signal("card_unclicked", self)

func _on_area_2d_area_entered(area):
	var parent = area.get_parent()
	emit_signal("collection_entered", self, parent)

func _on_area_2d_area_exited(area):
	var parent = area.get_parent()
	emit_signal("collection_exited", self, parent)

func _process(delta):
	if clicked:
		if draggable:
			target_position = get_global_mouse_position() - (custom_minimum_size * 0.5)
	position = target_position
