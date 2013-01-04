package com.boased.services 
{
	
	import flash.display.MovieClip;
	import flash.net.Responder;
	import flash.net.NetConnection;
	import flash.events.*;
	
	import com.boased.events.AMFEvent;

	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class AMFConnector 
	{

		private static var gateway:String;
		private static var connectionTresc:NetConnection;
		
		public static var caller:MovieClip;
		public static var amfResponse:Object;

		
		public function AMFConnector() 
		{
			
		}

		public static function init():void
		{
			gateway = "http://horalkygames.fbmanager.pl/";
			connectionTresc = new NetConnection;
			connectionTresc.connect(gateway);
		}

		public static function updateRank(_caller:MovieClip, _fbId:String, _name:String, _score:String, _categoryId:String):void 
		{
			var params:Object = new Object();
			params.fbId = _fbId;
			caller = _caller;
			params.name= _name;
			params.score= _score;
			params.categoryId = _categoryId;
			
			connectionTresc.call("Amf.updateRank", new Responder(trescRespond4, onFault) , params);
		}
		
		public static function trescRespond4(result:Object):void {
			amfResponse = result;
			caller.evtDispatcher.dispatchEvent(new AMFEvent(AMFEvent.RECIEVED));
		}

		public static function getRank(_caller:MovieClip, _fbId:String, _categoryId:String):void 
		{
			var params:Object = new Object();
			params.fbId = _fbId;
			params.categoryId = _categoryId;
			caller = _caller;
			connectionTresc.call("Amf.getRank", new Responder(trescRespond5, onFault) ,params);
		}
		
		public static function trescRespond5(result:Object):void 
		{	
			amfResponse = result;
			caller.evtDispatcher.dispatchEvent(new AMFEvent(AMFEvent.RECIEVED));
		}

		public static function onFault(fault:Object):void {
			trace("amf fault");
		}
		
	}

}