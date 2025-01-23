using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Threading;

public partial class P2p : Node
{
	private TcpListener? tcpListener;
	private List<TcpClient> tcpClients = new List<TcpClient>();
	private TcpClient _newClient {get;set;}
	public List<Thread?> ClientThreads {get;set;} = [];
	
	public async Task StartServer(int port)
	{
		int port = 40404; // Localhost. Change to actual IP? Can the program find it?
		_tcpListener = new TcpListener(IPAddress.Any, port); // creates listener using port and hostAdress
		_tcpListener.Start(); // starts listener created above
		
		while(true)
		{
			var opponent = tcpListener.AcceptTcpClient();
			_newClient = opponent;
			tcpClients.Add(opponent);
			var task = ClientHandler();
		}
	}

	private async Task ClientHandler()
	{
		var opponent = _newClient;
		var stream = opponent.GetStream();
		var reader = new StreamReader(stream);
		
		while(true)
		{
			var move = await reader.ReadLineAsync();
			
			var writer = new StreamWriter(client.GetStream()) { AutoFlush = true };
			writer.WriteLine(move);
		}
		
		// To close the connection. Not sure how this will play out, commenting it out for now.
		//finally
		//{
			//tcpClients.Remove(client);
			//opponet.Close();
		//}

	}
