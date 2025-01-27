using System;
using Godot;

public class NetworkServer : Node
{
	private NetworkedMultiplayerENet _peer;
	
	public override void _Ready()
	{
		StartServer();
	}
	
	public void StartServer()
	{
		_peer = new NetworkedMultiplayerENet;
		_peer.CreateServer(40404);
		GetTree().NetworkPeer = _peer
	}
	
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
}
