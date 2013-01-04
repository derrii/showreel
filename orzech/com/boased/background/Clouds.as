package com.boased.background 
{
	
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.greensock.TweenMax;
	
	import com.boased.config.GlobalConfiguration;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class Clouds extends MovieClip
	{
		

		
		public var tweenTime:Number = 60;
		
		
		public function Clouds():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			start();
		}
		
		private function start():void 
		{
			TweenMax.to(this, tweenTime, { x:x - GlobalConfiguration.CLOUDS_TWEEN_MARGIN } );
		}
		
	}

}