tool
extends Container

var id setget set_id,get_id
export(NodePath) var block_to_collapse_path setget set_block_to_collapse_path,get_block_to_collapse_path
var block_to_collapse setget set_block_to_collapse,get_block_to_collapse
onready var is_collapsed = false setget ,is_collapsed
	
func _ready():
	if (block_to_collapse_path != null):
		set_block_to_collapse(get_node(block_to_collapse_path))
	if ($hbox/btn_hide != null):
		if (!$hbox/btn_hide.is_connected("pressed", self, "_on_collapse_block_pressed")):
			$hbox/btn_hide.connect("pressed", self, "_on_collapse_block_pressed")

func set_id(v):
	id = v
	$hbox/id.text = str(id)

func get_id():
	return id

func set_block_to_collapse_path(v):
	block_to_collapse_path = v
	print('test 10') # @remove
	print(v) # @remove
	if v and has_node(v):
		set_block_to_collapse(get_node(v))

func get_block_to_collapse_path():
	return block_to_collapse_path

func set_block_to_collapse(v):
	block_to_collapse = null
	if (v != null):
		block_to_collapse = v

func get_block_to_collapse():
	return block_to_collapse
	
func is_collapsed():
	return is_collapsed

# Show/Hide block button pressed, and resize GraphNode to its minimum size
func _on_collapse_block_pressed():
	# security : print error if node_to_collapse not set in the block node
	if (block_to_collapse == null):
		printt("ERROR: Node to collapse not set in block ", self.name)
		pass
	else:
		if !block_to_collapse.visible:
			block_to_collapse.visible = true
			is_collapsed = false
		else:
			block_to_collapse.visible = false
			is_collapsed = true
			if get_parent() != get_viewport():
				printt("PARENT SIZE", get_parent().get_size())
				get_parent().set_size( Vector2(get_parent().get_size().x, 0) )
 
