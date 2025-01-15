extends Sprite2D

const BOARD_SIZE = 8

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
	pass # Replace with function body.
