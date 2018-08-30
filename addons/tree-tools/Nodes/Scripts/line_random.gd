tool
extends "res://addons/tree-tools/Nodes/Globals/node.gd"

onready var vbox_block = $VBoxContainer/vbox_block
onready var statement = $vbox/statement

#############################
# line_random is still broken
#############################


func _init():
	self.type = "line_random"

func _ready():
	pass

func save_data(node_list):
	node_list.push_back({
		"type": self.type,
		"id": name,
		"x": get_offset().x,
		"y": get_offset().y,
#		"lines": get_node("vbox_main_container/vbox_line/vbox_block/lines").text.percent_encode(),
#		"anim": get_node("vbox_main_container/vbox_line/vbox_block/anim").text.percent_encode(),
		"hidden": vbox_block.is_collapsed()
	})

func load_data(data):
	set_id(data["id"])
	set_name( data["id"])
	set_offset( Vector2(data["x"], data["y"]))
#	get_node("vbox_main_container/vbox_line/vbox_block/lines").text = data["lines"]
#	get_node("vbox_main_container/vbox_line/vbox_block/anim").text = data["anim"]
	if data.has("hidden"):
		if data["hidden"] == true:
			vbox_block._on_collapse_block_pressed()

func export_data(file, connections, labels):
	file.store_line("func " + name + "(c):")
	var statement_val = statement.text
	if statement_val == "":
		statement_val = "true"
	var branch_true = ""
	var branch_false = ""
	for conn in connections:
		if conn["from_port"] == 1:
			branch_true = conn["to"]
		if conn["from_port"] == 2:
			branch_false = conn["to"]
	file.store_line("\tif " + statement_val + ":")
	if branch_true != "":
		file.store_line("\t\t" + branch_true + "(c)")
	else:
		file.store_line("\t\tpass")
	if branch_false != "":
		file.store_line("\telse:")
		file.store_line("\t\t" + branch_false + "(c)")
