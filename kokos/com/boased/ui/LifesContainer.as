package com.boased.ui 
{
	import flash.display.MovieClip;
	import flash.display.*;
	import flash.events.*;
	
	import com.greensock.TweenMax;
	
	import com.boased.config.GlobalConfiguration;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class LifesContainer extends MovieClip
	{

		public var lifesSpritesArray:Array = new Array();
		public var currentLifes:int;
		
		public function LifesContainer():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addtoStageHandler);
			
		}
		
		private function addtoStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addtoStageHandler);
			init();
		}
		
		private function init():void 
		{
			for (var i:int = 1 ; i <= GlobalConfiguration.PLAYER_DEFAULT_LIFES ; i++)
			{
				lifesSpritesArray.push(this["life"+(GlobalConfiguration.PLAYER_DEFAULT_LIFES+1-i)]);
			}
			currentLifes = GlobalConfiguration.PLAYER_DEFAULT_LIFES;
			
		}
		
		public function reset():void
		{
			for each (var life:MovieClip in lifesSpritesArray)
			{
				life.visible = true;
			}
			currentLifes = GlobalConfiguration.PLAYER_DEFAULT_LIFES;
		}
		
		public function lifeDown():void
		{
			
			for each (var life:MovieClip in lifesSpritesArray)
			{
				
				life.visible = false;
			}
			
			for (var i = 1; i <= GlobalConfiguration.application.lifeManager.lifesLeft; i++)
			{
				lifesSpritesArray[i-1].visible = true;
			}
			
		}
		
	}

}