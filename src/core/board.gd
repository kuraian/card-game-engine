class_name Board extends Control

@export var card_scene : PackedScene

func _ready():
	var new_card = card_scene.instantiate()
	for i in range(2):
		new_card = card_scene.instantiate()
		new_card.card_clicked.connect(_on_card_clicked)
		new_card.card_unclicked.connect(_on_card_unclicked)
		new_card.collection_entered.connect(_on_collection_entered)
		new_card.collection_exited.connect(_on_collection_exited)
		add_child(new_card)

func _on_signal(arg1=null, arg2=null, arg3=null, arg4=null, arg5=null): # generic signal tester, please add variadic functions
	#print("%s, %s, %s, %s, %s" % [arg1, arg2, arg3, arg4, arg5])
	print(arg1)
	print(arg2)

func _on_card_clicked(card):
	print("clicked")
	
func _on_card_unclicked(card):
	print("unclicked")

func _on_collection_entered(card, collection):
	print(card, " entered ", collection)
	card.add_to_group(collection.collection_name)
	print("in group: ", get_tree().get_nodes_in_group(collection.collection_name))
	
func _on_collection_exited(card, collection):
	print(card, " exited ", collection)
	card.remove_from_group(collection.collection_name)
	print("in group: ", get_tree().get_nodes_in_group(collection.collection_name))
	
func _process(delta):
	pass
