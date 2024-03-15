class_name Board extends Control

@export var card_scene : PackedScene

func _ready():
	var new_card = card_scene.instantiate()
	for i in range(2):
		new_card = card_scene.instantiate()
		new_card.card_clicked.connect(_on_signal)
		new_card.card_unclicked.connect(_on_card_unclicked)
		add_child(new_card)

func _on_signal(arg1=null, arg2=null, arg3=null, arg4=null, arg5=null): # generic signal tester, please add variadic functions
	#print("%s, %s, %s, %s, %s" % [arg1, arg2, arg3, arg4, arg5])
	pass

func _on_card_unclicked(card):
	print("unclicked")

func _process(delta):
	pass
