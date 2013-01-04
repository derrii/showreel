


package com.boased.business 
{
	import com.boased.events.LifeEvent;
	import flash.events.*;
	import flash.display.*;
	
	import com.boased.config.GlobalConfiguration;

	import com.greensock.TweenMax;
	
	
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class LifeManager 
	{
		
		public static var lifeManager:LifeManager;
		public var evtDispatcher:EventDispatcher = new EventDispatcher();
		
		public var lifesLeft:Number;
		
		
		public static function getInstance():LifeManager
		{
			if (lifeManager == null)
			{
				lifeManager = new LifeManager();
			}
			return lifeManager;
		}
		
		public function LifeManager() 
		{
			if (lifeManager != null)
			{
				throw new Error("LifeManager is a singleton and should not be instantiated. Use getInstance() instead");
			}
		}
		
		public function lifeLost():void
		{
			evtDispatcher.dispatchEvent(new LifeEvent(LifeEvent.LIFE_LOST));
			if (lifesLeft > 0)
			{
				lifesLeft--;
				gameNextLife();
			} else
			{
				gameOver();
			}
			
		}
		
		private function gameNextLife():void 
		{
			//GlobalConfiguration.application.lifeDown();
			//TweenMax.delayedCall(0.1, GlobalConfiguration.application.nextLife);
			GlobalConfiguration.application.nextLife();
		}
		
		private function gameOver():void 
		{
			evtDispatcher.dispatchEvent(new LifeEvent(LifeEvent.GAME_LOST));
			GlobalConfiguration.application.gameOver();
		}

		public function reset():void
		{
			lifesLeft = GlobalConfiguration.PLAYER_DEFAULT_LIFES;
		}
		
	}

}