package com.boased.background 
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class WaterEffect extends MovieClip
	{

		private var defYwater1:Number;
		private var defYwater2:Number;

		private static const MOVEMENT_MARGIN:Number = 660;
		
		private static const DIRECTION_UP:String = "dirup";
		private static const DIRECTION_DOWN:String = "dirdown";
		
		private var currentDirection:String;
		
		public function WaterEffect() 
		{
			
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function init():void 
		{
			defYwater1 = water.waterAnim.y;
			defYwater2 = water.waterAnim2.y;
			currentDirection = WaterEffect.DIRECTION_DOWN;
			TweenPlugin.activate([GlowFilterPlugin]);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			init();
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			
			TweenMax.to(islands_mc, 0, { glowFilter: { blurX:12, blurY:12, strength:0.1, color:0xB4DFEE, alpha:1 }, ease:Bounce.easeInOut } );
			
			islandsAnimStart();
			addEventListener(Event.ENTER_FRAME, waterAnimStart);
			
		}

		
//TODO doszlifować animację tak żeby krawędzi nie było
		private function waterAnimStart(e:Event):void 
		{
			
			if (currentDirection == DIRECTION_DOWN)
			{
			
				if (water.waterAnim.y > defYwater1 - MOVEMENT_MARGIN)
				{
			
					water.waterAnim.y -=0.3;
					water.waterAnim2.y += 0.3;
				} else
				{
					
					currentDirection = DIRECTION_UP;
				}
			} else if (currentDirection == DIRECTION_UP)
			{
				if (water.waterAnim.y < defYwater1 + MOVEMENT_MARGIN)
				{
					water.waterAnim.y +=0.3;
					water.waterAnim2.y -= 0.3;
				} else
				{
					
					currentDirection = DIRECTION_DOWN;
				}
			}
		}

		private function islandsAnimStart():void 
		{
			TweenMax.to(islands_mc, 4, { glowFilter: { blurX:12, blurY:12, strength:2, color:0xB4DFEE, alpha:1 }, 
			 onComplete:function() {
				TweenMax.to(islands_mc, 4, { glowFilter: { blurX:12, blurY:12, strength:0.1, color:0xB4DFEE, alpha:1 }, 
				onComplete:function() { 
					islandsAnimStart();
					}} );
				} } );
			
		}
		
		
		
	}

}