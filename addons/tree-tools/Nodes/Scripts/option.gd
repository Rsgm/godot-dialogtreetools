tool
extends "res://addons/tree-tools/Nodes/Globals/node.gd"

func _init():
	self.type = "option"
	self.new_block_collapsed = true
	self.first_left_slot = true
	self.first_right_slot = true
	self.new_block_adds_left_slot = false
	self.new_block_adds_right_slot = true
	self.left_slot_type = 0
	self.right_slot_type = 0

func _ready():
	self.block_scene = load("res://addons/tree-tools/Nodes/SubNodes/option_block.tscn")
	add_new_block()


func load_data(data):
	clear_blocks()
	set_id( data["id"] )
	set_name( data["id"] )
	
	set_offset( Vector2(data["x"], data["y"]))

	var currentBlock = 0
	var keyData = "data" 
	while data.has( keyData + str(currentBlock)):
		var new_block = add_new_block()
		print("test 7") # @remove
		print(new_block) # @remove
		new_block.set_data( data[keyData + str(currentBlock)] )
		
		currentBlock += 1