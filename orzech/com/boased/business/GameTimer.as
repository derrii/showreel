package com.boased.business 
{
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	
	import com.greensock.TweenMax;
	import flash.events.EventDispatcher;
	import com.boased.events.TimeEvent;
	
	public class GameTimer 
	{
		
		public static var gameTimer:GameTimer;
		
		public var defaultTimeRemaining:int;
		public var timeRemaining:int;
		
		public var evtDispatcher:EventDispatcher = new EventDispatcher();
		
		public static function getInstance(_defaultTimeRemaining:Number):GameTimer
		{
			if (gameTimer == null)
			{
				gameTimer = new GameTimer();
				gameTimer.defaultTimeRemaining = _defaultTimeRemaining;
				gameTimer.timeRemaining = gameTimer.defaultTimeRemaining;
			}
			return gameTimer;
		}
		
		public function GameTimer() 
		{
			if (gameTimer != null)
			{
				throw new Error("GameTimer is a singleton and should not be instantiated. Use getInstance() instead");
			}
		}
		
		public function activate():void
		{
			TweenMax.delayedCall(1, timerDown);
		}
		
		private function timerDown():void
		{
			timeRemaining--;
			evtDispatcher.dispatchEvent(new TimeEvent(TimeEvent.TIME_PROGRESS));
			
			if (timeRemaining == 0)
			{
				evtDispatcher.dispatchEvent(new TimeEvent(TimeEvent.TIME_OVER));
			} else
			{
				TweenMax.delayedCall(1, timerDown);
			}
		}
		
		public function reset():void
		{
			timeRemaining = defaultTimeRemaining;
		}
		
		
	}

}