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
var white : bool
var state : bool
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
		if event.button_index == LEFT_MOUSE_BUTTON:
			if is_mouse_out(): return
			
func is_mouse_out():
	get_global_mouse_position().x < 0 || get_global_mouse_position().x > 144 || get_global_mouse_position().y > 0 || get_global_mouse_position().y < -144

	
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
