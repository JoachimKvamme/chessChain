using System;
using Godot;

public class NetworkServer : Node
{
	private ENetMultiplayerPeer _peer;
	
	public override void _Ready()
	{
		StartServer();
	}
	
	public void StartServer()
	{
		_peer = new ENetMultiplayerPeer();
		_peer.CreateServer(40404);
		GetTree().MultiplayerPeer = _peer;
		_peer.Connect("peer_connected", this, nameof(OnPeerConnected));
		_peer.Connect("peer_disconnected", this, nameof(OnPeerDisconnected));
	}
	

	private void OnPeerConnected(int id)
	{
		GD.Print($"Peer connected: {id}");
	}

	private void OnPeerDisconnected(int id)
	{
		GD.Print($"Peer disconnected: {id}");
	}
	
	public void SendMoveRemote(string move)
	{
		GD.Print($"Move received: {move}");
	}
}
