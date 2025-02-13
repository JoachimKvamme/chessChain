extends RichTextLabel
 
var all_moves = [["d4","d5"],["c4","dxc4"]] # fetcher trekk nå de er tilgjengelig igjen

func _ready() -> void:
	_display_moves(all_moves) 


func _display_moves(moves: Array) -> void:
	var moves_as_string = ""
	for moveset in moves:
		moves_as_string += "%d,%d\n" % [moveset[0], moveset[1]]
		
	text = moves_as_string
