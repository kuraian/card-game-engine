@tool
class_name	CardUI extends Control

signal card_hovered(card: CardUI)
signal card_unhovered(card: CardUI)
signal card_clicked(card: CardUI)
signal card_unclicked(card: CardUI)

@onready var card_base = $Base
@onready var card_icon = $Icon

@export var card_data : CardUIData

var card_base_texture : String
var card_icon_texture : String
var is_hovered := false
var is_clicked := false
var is_draggable := true
var hover_distance := 20
var target_position := Vector2.ZERO

func set_disabled(val: bool):
	if val:
		is_hovered = false
		is_clicked = false
		is_draggable = false

func get_interactability():
	var valid = true
	return valid
	
func _ready():
	connect("mouse_entered", _on_mouse_enter)
	connect("mouse_exited", _on_mouse_exit)
	connect("gui_input", _on_gui_input)
	
	custom_minimum_size = card_base.get_size()
	mouse_filter = Control.MOUSE_FILTER_PASS

func _on_mouse_enter():
	if get_interactability():
		is_hovered = true
		target_position.y -= hover_distance
		emit_signal("card_hovered", self)
		
func _on_mouse_exit():
	if is_clicked:
		return
	if is_hovered:
		is_hovered = false
		target_position.y += hover_distance
		emit_signal("card_unhovered", self)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if get_interactability():
				is_clicked = true
				emit_signal("card_clicked", self)
		else:
			if is_clicked:
				is_clicked = false
				emit_signal("card_unclicked", self)

func _process(delta):
	if is_clicked:
		if is_draggable:
			target_position = get_global_mouse_position() - (custom_minimum_size * 0.5)
		position = target_position
	
