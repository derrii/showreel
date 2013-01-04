package com.boased.events 
{
	import flash.events.Event;
	
	public class AMFEvent extends Event 
	{
		
		public static var RECIEVED:String = "recieved";
		
		public function AMFEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);		
		} 
		
		public override function clone():Event 
		{ 
			return new AMFEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AMFEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}