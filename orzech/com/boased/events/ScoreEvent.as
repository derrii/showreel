package com.boased.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class ScoreEvent extends Event 
	{

		public static const CHANGE:String = "change";
		
		public function ScoreEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ScoreEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ScoreEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}