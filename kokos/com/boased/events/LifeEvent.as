package com.boased.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class LifeEvent extends Event 
	{

		public static const LIFE_LOST:String = "lifelost";
		public static const GAME_LOST:String = "gamelost";
		
		public function LifeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new LifeEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LifeEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}