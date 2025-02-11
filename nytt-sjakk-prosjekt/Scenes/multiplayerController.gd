extends Control

@export var adress = "127.0.0.1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func peer_connected(id):
	print("Player connected" + id)

func peer_disconnected(id):
	print("Player disconnected" + id)

func connected_to_server():
	print("Connected to server")

func connection_failed():
	print("Connection failed")

func _on_host_button_down() -> void:
	pass # Replace with function body.


func _on_join_button_down() -> void:
	pass # Replace with function body.


func _on_button_button_down() -> void:
	pass # Replace with function body.
