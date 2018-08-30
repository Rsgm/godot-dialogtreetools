tool
extends "res://addons/tree-tools/Nodes/Globals/node.gd"


func _init():
	self.type = "startnode"

##############

func save_data(nodes_list):
	print("Save startnode")
	
	nodes_list.push_back({
		"type": self.type,
		"id": name,
		"x": get_offset().x,
		"y": get_offset().y,
		"name": $vbox/name.text
	})

func load_data(data):
	set_id( data["id"])
	set_name( data["id"])
	set_offset( Vector2(data["x"], data["y"]))
	$vbox/name.text = data["name"]

func export_data(file, connections, labels):
	var next = ""
	var name_val = $vbox/name.text.percent_encode()
	for c in connections:
		next = c["to"]
	labels[name_val] = next
