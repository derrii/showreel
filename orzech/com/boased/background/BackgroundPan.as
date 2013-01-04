package com.boased.background 
{
	import flash.display.*;
	import flash.events.*;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.*;

	import com.boased.config.GlobalConfiguration;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class BackgroundPan extends MovieClip
	{

		private static const MOVEMENT_SPEED:Number = 0.3;
		
		private var defaultX:Number;
		
		public var movementMargin:Number;
		
		public function BackgroundPan():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			defaultX = this.x;
		}
		
		public function start():void 
		{
			addMovementListeners();
		}
		
		private function addMovementListeners():void 
		{
			stage.addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function render(e:Event):void 
		{
			
			var xPos:Number = MovieClip(GlobalConfiguration.application.player).x;
			
			var delta:Number;
			
			if (xPos >= 360)
			{
				delta = (xPos - 360) / 360 * movementMargin;
			} else
			{
				delta = -((1-(xPos / 360)) * movementMargin);
			}
			
			//TweenMax.to(this, MOVEMENT_SPEED, { x:defaultX + delta} );
			x = defaultX + delta;
		}
		
	}

}