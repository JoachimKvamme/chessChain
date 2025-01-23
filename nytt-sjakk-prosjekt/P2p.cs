using Godot;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Threading;



public partial class P2p : Node
{
	private TcpListener _tcpListener;
	private TcpClient _tcpClient{get;set;}
	
	public void TCPServer()
	{
		
	}
	
	private void StartServer()
	{
		int port = 40404; // Localhost. Change to actual IP? Can the program find it?
		_tcpListener = new TcpListener(IPAddress.Any, port); // creates listener using port and hostAdress
		_tcpListener.Start(); // starts listener created above
		
		while(true)
		{
			var opponent = _tcpListener.AcceptTcpClient();
			_tcpClient = opponent;
			var task = ClientHandler();
		}
	}
	
	private async Task ClientHandler()
	{
		var opponent = _tcpClient;
		var stream = opponent.GetStream();
		var reader = new StreamReader(stream);

		while(true)
		{
			var move = await reader.ReadLineAsync();
			WriteMessage(move, opponent.Client.Handle);
		}
		
		// To close the connection. Not sure how this will play out, commenting it out for now.
		//finally
		//{
			//opponent.Close();
		//}
	}
	
	private void WriteMessage(string move, int handle)
	{
		
	}
}
