@tool
class_name	Card extends Control

signal card_hovered(card: Card)
signal card_unhovered(card: Card)
signal card_clicked(card: Card)
signal card_unclicked(card: Card)
signal collection_entered(collection: CardCollection)
signal collection_exited(collection: CardCollection)

@onready var card_base = $Base
@onready var card_icon = $Icon

@export var card_data : CardData

var card_base_texture : String
var card_icon_texture : String
var is_enabled := true
var is_hovered := false
var is_clicked := false
var is_draggable := true
var hover_distance := 20
var target_position := Vector2.ZERO

func set_disabled():
	is_hovered = false
	is_clicked = false
	is_draggable = false
	is_enabled = false
	
func set_enabled():
	is_enabled = true
	
func _ready():
	mouse_entered.connect(_on_mouse_enter)
	mouse_exited.connect(_on_mouse_exit)
	gui_input.connect(_on_gui_input)
	
	custom_minimum_size = card_base.get_size()
	mouse_filter = Control.MOUSE_FILTER_PASS

func _on_mouse_enter():
	if is_enabled:
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
			if is_enabled:
				is_clicked = true
				is_hovered = false
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


func _on_area_2d_area_entered(area):
	print("entered", area)


func _on_area_2d_area_exited(area):
	print("exited", area)
