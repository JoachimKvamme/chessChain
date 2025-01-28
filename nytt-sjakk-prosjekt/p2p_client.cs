using Godot;
using System;

public partial class NetworkClient : Node
{
	
	private ENetMultiplayerPeer _peer;
	
	public override void _Ready()
	{
		string ipAdress = "127.0.0.1";
		int port = 40404;
		ConnectToServer(ipAdress, port);
	}
	
	public void ConnectToServer(string ipAdress, int port)
	{
		_peer = ENetMultiplayerPeer;
		_peer.CreateClient(ipAdress, port);
		GetTree().MultiplayerPeer = _peer;
		
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
	public void SendMove(string move)
	{
		RpcId(1, nameof(SendMove), move); // Send to server (id=1)
	}

	public void SendMoveRemote(string move)
	{
		GD.Print($"{move}");
	}
}
