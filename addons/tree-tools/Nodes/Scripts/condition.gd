tool
extends "res://addons/tree-tools/Nodes/Globals/node.gd"

onready var statement = $vbox/statement

func _init():
	self.type = "condition"

func _on_close_request():
	queue_free()

func save_data(node_list):
	node_list.push_back({
		"type": self.type,
		"id": name,
		"x": get_offset().x,
		"y": get_offset().y,
		"statement": statement.text.percent_encode()
	})

func load_data(data):
	set_id( data["id"])
	set_name( data["id"])
	set_offset( Vector2(data["x"], data["y"]))
	statement.text = data["statement"]

func export_data(file, connections, labels):
	file.store_line("func " + name + "(c):")
	var statement = statement.text
	if statement == "":
		statement = "true"
	var branch_true = ""
	var branch_false = ""
	for conn in connections:
		if conn["from_port"] == 1:
			branch_true = conn["to"]
		if conn["from_port"] == 2:
			branch_false = conn["to"]
	file.store_line("\tif " + statement + ":")
	if branch_true != "":
		file.store_line("\t\t" + branch_true + "(c)")
	else:
		file.store_line("\t\tpass")
	if branch_false != "":
		file.store_line("\telse:")
		file.store_line("\t\t" + branch_false + "(c)")
