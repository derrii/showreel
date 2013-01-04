package com.boased.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class TimeEvent extends Event 
	{
		
		public static const TIME_OVER:String = "timeover";
		public static const TIME_PROGRESS:String = "timeprogress";
		
		public function TimeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new TimeEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TimeEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}