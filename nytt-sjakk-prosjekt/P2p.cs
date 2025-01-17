using Godot;
using System;
using System.Net;
using System.Net.Sockets;



public partial class P2p : Node
{
	//// Called when the node enters the scene tree for the first time.
	//public override void _Ready()
	//{
	//}
//
	//// Called every frame. 'delta' is the elapsed time since the previous frame.
	//public override void _Process(double delta)
	//
	
	private TcpListener _tcpListener;
	
	public TCPServer()
	{
		
	}
	
	private void StartServer()
	{
		int port = 40404;
		string hostAdress = IPAdress.Parse(127.0.0.1); // Localhost. Change to actual IP? Can the program find it?
		_tcpListener = new TCPListener(hostAdress, port); // creates listener using port and hostAdress
		_tcpListener.start(); // starts listener created above
		
		byte[] buffer = new byte[256];
		string receivedMessage; // TODO: Endre til noe mer fornuftig, so f.eks. "opponentsMove";
		
		using tcpClient client = _tcpListener.AcceptTcpClient();
		
		var tcpStream = client.GetStream();
		
		int readTotal;
		
		while(readTotal = topStream.Read(buffer, 0, buffer.Length) != 0)
		{
			string incomingMessage = UTF8.GetString(buffer, 0, buffer.length);
		}
		//adding parsed data loop in the future here.
	}
}
