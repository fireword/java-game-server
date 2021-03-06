package org.menacheri.jetclient 
{
	/**
	 * Used to create a TCP socket connection to remote Jetserver.
	 * @author Abraham Menacherry
	 */
	public class JetClient
	{
		import flash.events.*;
		import flash.utils.ByteArray;
		import flash.utils.Dictionary;
		import flash.net.Socket;
		import flash.system.Security;
		import org.menacheri.jetclient.codecs.Transform;
		import org.menacheri.jetclient.event.JetEvent;
		
		private var remoteHost:String;
		private var remotePort:int;
				
		public function JetClient(remoteHost:String, remotePort:int) 
		{
			this.remoteHost = remoteHost;
			this.remotePort = remotePort;
		}
		
		public function connect(loginBytes:ByteArray):Socket
		{
			var socket:Socket = new Socket(remoteHost, remotePort);
			socket.addEventListener(Event.CONNECT, socketConnect);
			socket.addEventListener(Event.CLOSE, socketClose);
			socket.addEventListener(IOErrorEvent.IO_ERROR, socketError);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
								
			
			try {
                	trace("Trying to connect to " + remoteHost + ":" + remotePort + "\n");
                	socket.connect(remoteHost, remotePort);
					socket.writeBytes(loginBytes);
			} catch (error:Error) {
			/*
			 *   Unable to connect to remote server, display error 
			 *   message and close connection.
			 */
			    trace(error.message + "\n");
			    socket.close();
			    throw (error);
			}
			return socket;
		}
		
		public function socketConnect(event:Event):void {
			trace("Connected: " + event);
		}
		
		public function socketData(event:ProgressEvent):void {
			trace("Receiving data: " + event);
			//receiveData(this.socket.r(this.socket.bytesAvailable));
		}
		
		public function socketClose(event:Event):void {
			trace("Connection closed: " + event);
			//this.chatArea.appendText("Connection lost." + "\n");
		}
		
		public function socketError(event:IOErrorEvent):void {
			trace("Socket error: " + event);
		}
		
		public function securityError(event:SecurityErrorEvent):void {
			trace("Security error: " + event);
		}
	}

}