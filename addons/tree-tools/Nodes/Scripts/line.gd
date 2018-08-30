tool
extends "res://addons/tree-tools/Nodes/Globals/node.gd"


func _init():
	self.type = "line"
	self.new_block_adds_left_slot = false
	self.new_block_adds_right_slot = false
	self.left_slot_type = 0
	self.right_slot_type = 0

func _ready():
	self.block_scene = load("res://addons/tree-tools/Nodes/SubNodes/line_block.tscn")
	add_new_block()

func load_data(data):
	clear_blocks()
	set_id( data["id"] )
	set_name(  data["id"] )
	set_offset( Vector2(data["x"], data["y"]))

	var currentBlock = 0
	var keyData = "data" 
	while data.has( keyData + str(currentBlock)):
		var new_block = add_new_block()
		new_block.set_data( data[keyData + str(currentBlock)] )
		
		currentBlock += 1