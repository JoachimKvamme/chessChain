using Godot;
using System;

public partial class HostButton : Button
{
	[Export] private NodePath serverPath;
	private NetworkServer _server;

	public override void _Ready()
	{
		_server = GetNode<NetworkServer>(serverPath);
	}

	private void OnHostPressed()
	{
		if (_server != null)
		{
			GD.Print("Starting server...");
			_server.StartServer();
		}
		else
		{
			GD.PrintErr("Server node not found!");
		}
	}
}
