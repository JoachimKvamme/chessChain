using Godot;
using System;

public partial class NetworkClient : Node
{
	
	private NetworkedMultiplayerENet _peer;
	
	public override void _Ready()
	{
		string ipAdress = "127.0.0.1";
		int port = 40404;
		ConnectToServer(ipAdress, port);
	}
	
	public void ConnectToServer(string ipAdress, int port)
	{
		_peer = NetworkedMultiplayerENet;
		_peer.CreateClient(ipAdress, port)
		GetTree().NetworkPeer = _peer;
		
		_peer.Connect("connection_failed", this, nameof(OnConnectionFailed));
		_peer.Connect("server_disconnected", this, nameof(OnServerDisconnected));
	}
	
	private void OnConnectionFailed()
	{
		GD.Print("Connection failed!");
	}

	private void OnServerDisconnected()
	{
		GD.Print("Disconnected from server!");
	}
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
