package com.boased.sprites 
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import com.boased.config.GlobalConfiguration;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class Plusk extends MovieClip implements ISprite
	{
		
		public function Plusk():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			this.visible = false;
//TODO asasdasd
			//init();
		}
		
		public function randomizeLocation():void
		{
			//
		}
		
		public function lifeCycleStart():void
		{
			//
		}
		
		public function setAndPlay(_x:Number, _y:Number):void
		{
			this.x = _x;
			this.y = _y;
			this.visible = true;
			this.gotoAndPlay(1);
			
		}
		
	}

}