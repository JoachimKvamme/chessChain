extends Sprite2D

const BOARD_SIZE = 8
const CELL_WIDHT = 18

const TEXTURE_HOLDER = preload("res://Scenes/texture_holder.tscn")

const BLACK_BISHOP = preload("res://Assets/Chess/black_bishop.png")
const BLACK_KING = preload("res://Assets/Chess/black_king.png")

const BLACK_KNIGHT = preload("res://Assets/Chess/black_knight.png")
const BLACK_PAWN = preload("res://Assets/Chess/black_pawn.png")
const BLACK_QUEEN = preload("res://Assets/Chess/black_queen.png")
const BLACK_ROOK = preload("res://Assets/Chess/black_rook.png")
const WHITE_BISHOP = preload("res://Assets/Chess/white_bishop.png")
const WHITE_KING = preload("res://Assets/Chess/white_king.png")
const WHITE_KNIGHT = preload("res://Assets/Chess/white_knight.png")
const WHITE_PAWN = preload("res://Assets/Chess/white_pawn.png")
const WHITE_QUEEN = preload("res://Assets/Chess/white_queen.png")
const WHITE_ROOK = preload("res://Assets/Chess/white_rook.png")

const PIECE_MOVE = preload("res://Assets/Chess/Piece_move.png")

const TURN_WHITE = preload("res://Assets/Chess/turn-white.png")
const TURN_BLACK = preload("res://Assets/Chess/turn-black.png")

@onready var pieces: Node2D = $pieces
@onready var dots: Node2D = $dots
@onready var turn: Sprite2D = $turn


# variables
# -6 = black king
# -5 = black queen
# -4 = black rook
# -3 = black bishop
# -2 = black knight
# -1 = black pawn
#  0
#  6 white king
#  5 white queen
#  4 white rook
#  3 white bishop
#  2 white knight
#  1 white pawn

var board : Array
var white : bool = true
var state : bool = false
var moves = []
var selected_piece : Vector2





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	board.append([4, 2, 3, 5, 6, 3, 2, 4])
	board.append([1, 1, 1, 1, 1, 1, 1, 1])
	board.append([0, 0, 0, 0, 0, 0, 0, 0])
	board.append([0, 0, 0, 0, 0, 0, 0, 0])
	board.append([0, 0, 0, 0, 0, 0, 0, 0])
	board.append([0, 0, 0, 0, 0, 0, 0, 0])
	board.append([-1, -1, -1, -1, -1, -1, -1, -1])
	board.append([-4, -2, -3, -5, -6, -3, -2, -4])
	
	display_board()

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			if is_mouse_out(): return
			var var1 = snapped(get_global_mouse_position().x, 0) / CELL_WIDHT
			var var2 = abs(snapped(get_global_mouse_position().y, 0) / CELL_WIDHT)
			if !state && (white && board[var2][var1] > 0 || !white && board[var2][var1] < 0):
				selected_piece = Vector2(var2, var1)
				show_options()
				state = true
			elif state:
				set_moves(var2, var1)
			
func is_mouse_out():
	if get_global_mouse_position().x < 0 || get_global_mouse_position().x > 144 || get_global_mouse_position().y > 0 || get_global_mouse_position().y < -144: return true
	return false
	
func display_board():
	for i in BOARD_SIZE:
		for j in BOARD_SIZE:
			var holder = TEXTURE_HOLDER.instantiate()
			pieces.add_child(holder)
			holder.global_position = Vector2(j * CELL_WIDHT + (CELL_WIDHT / 2), -i * CELL_WIDHT - (CELL_WIDHT / 2))
			
			match board[i][j]:
				-6: holder.texture = BLACK_KING
				-5: holder.texture = BLACK_QUEEN
				-4: holder.texture = BLACK_ROOK
				-3: holder.texture = BLACK_BISHOP
				-2: holder.texture = BLACK_KNIGHT
				-1: holder.texture = BLACK_PAWN
				0: holder.texture = null
				6: holder.texture = WHITE_KING
				5: holder.texture = WHITE_QUEEN
				4: holder.texture = WHITE_ROOK
				3: holder.texture = WHITE_BISHOP
				2: holder.texture = WHITE_KNIGHT
				1: holder.texture = WHITE_PAWN

func show_options():
	moves = get_moves()
	if moves == []:
		state = false
		return
	show_dots()

func show_dots():
	for i in moves:
		var holder = TEXTURE_HOLDER.instantiate()
		dots.add_child(holder)
		holder.texture = PIECE_MOVE
		holder.global_position = Vector2(i.y * CELL_WIDHT  + (CELL_WIDHT / 2), -i.x * CELL_WIDHT - (CELL_WIDHT / 2))	

func set_moves(var2, var1):
	for i in moves:
		if i.x == var2 && i.y == var1: 
			board[var2][var1] = board[selected_piece.x][selected_piece.y]
	


func get_moves():
	var _moves = []
	
	match abs(board[selected_piece.x][selected_piece.y]):
		1: _moves = get_pawn_moves()
		2: _moves = get_knight_moves()
		3: _moves = get_bishop_moves()
		4: _moves = get_rook_moves()
		5: _moves = get_queen_moves()
		6: _moves = get_king_moves()
	
	return _moves

func get_rook_moves():
	var _moves = []
	var directions = [Vector2(0,1), Vector2(0, -1), Vector2(1, 0), Vector2(-1, 0)]
	
	for i in directions:
		var pos = selected_piece
		pos += i
		while is_valid_position(pos):
			if is_empty(pos): _moves.append(pos)
			elif is_enemy(pos): 
				_moves.append(pos)
				break
			else: break
			
			pos += i
	return _moves
	
func get_bishop_moves():
	var _moves = []
	var directions = [Vector2(1,1), Vector2(1, -1), Vector2(-1, 1), Vector2(-1, -1)]
	
	for i in directions:
		var pos = selected_piece
		pos += i
		while is_valid_position(pos):
			if is_empty(pos): _moves.append(pos)
			elif is_enemy(pos): 
				_moves.append(pos)
				break
			else: break
			
			pos += i
	return _moves
	
func get_queen_moves():
	var _moves = []
	var directions = [Vector2(0,1), Vector2(0, -1), Vector2(1, 0), Vector2(-1, 0),
	Vector2(1,1), Vector2(1, -1), Vector2(-1, 1), Vector2(-1, -1)]
	
	for i in directions:
		var pos = selected_piece
		pos += i
		while is_valid_position(pos):
			if is_empty(pos): _moves.append(pos)
			elif is_enemy(pos): 
				_moves.append(pos)
				break
			else: break
			
			pos += i
	return _moves
	
func get_king_moves():
	var _moves = []
	var directions = [Vector2(0,1), Vector2(0, -1), Vector2(1, 0), Vector2(-1, 0),
	Vector2(1,1), Vector2(1, -1), Vector2(-1, 1), Vector2(-1, -1)]
	
	for i in directions:
		var pos = selected_piece + i
		if is_valid_position(pos):
			if is_empty(pos): _moves.append(pos)
			elif is_enemy(pos): 
				_moves.append(pos)
	return _moves
	
func get_knight_moves():
	var _moves = []
	var directions = [Vector2(2,1), Vector2(2, -1), Vector2(1, 2), Vector2(-1, 2),
	Vector2(-2,1), Vector2(-2, -1), Vector2(-1, 2), Vector2(-1, -2)]
	
	for i in directions:
		var pos = selected_piece + i
		if is_valid_position(pos):
			if is_empty(pos): _moves.append(pos)
			elif is_enemy(pos): 
				_moves.append(pos)
	return _moves

func get_pawn_moves():
	var _moves = []
	var direction 
	var is_first_move = false
	
	if white : direction = Vector2(1, 0)
	else: direction = Vector2(-1, 0)
	
	if white && selected_piece.x == 1 || !white && selected_piece.x == 6: is_first_move = true
	
	var pos = selected_piece + direction 
	if is_empty(pos): _moves.append(pos)
	
	pos = selected_piece + Vector2(direction.x, 1)
	if is_valid_position(pos):
		if is_enemy(pos): _moves.append(pos)
		
	pos = selected_piece + Vector2(direction.x, -1)
	if is_valid_position(pos):
		if is_enemy(pos): _moves.append(pos)
		
	pos = selected_piece + direction * 2
	if is_first_move && is_empty(pos) && is_empty(selected_piece + direction): _moves.append(pos)
	
	return _moves
	

func is_valid_position(pos : Vector2):
	if pos.x >= 0 && pos.x < BOARD_SIZE && pos.y >= 0 && pos.y < BOARD_SIZE: return true
	return false
	
func is_empty(pos : Vector2):
	if board[pos.x][pos.y] == 0: return true
	return false

func is_enemy(pos : Vector2):
	if white && board[pos.x][pos.y] < 0 || !white && board[pos.x][pos.y] > 0: return true
	return false
