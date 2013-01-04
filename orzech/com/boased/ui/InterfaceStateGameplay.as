package com.boased.ui 
{
	import flash.display.MovieClip;
	
	import com.boased.config.GlobalConfiguration;
	import com.boased.utils.TimeFormat;
	
	import com.boased.events.ScoreEvent;
	import com.boased.events.TimeEvent;

	import com.greensock.TweenMax;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class InterfaceStateGameplay extends MovieClip implements IInterfaceState
	{
		
		public function GameplayInterface():void
		{
			
		}
		
		public function resetInterface():void
		{
			labels.timeLabel.txt.text = TimeFormat.intToString(GlobalConfiguration.DEFAULT_GAME_TIME);
			labels.scoreLabel.txt.text = GlobalConfiguration.DEFAULT_SCORE;
			GlobalConfiguration.application.gameTimer.evtDispatcher.addEventListener(TimeEvent.TIME_PROGRESS, timeProgressHandler);
			GlobalConfiguration.application.resultsBridge.evtDispatcher.addEventListener(ScoreEvent.CHANGE, scored);
			GlobalConfiguration.application.gameTimer.evtDispatcher.addEventListener(TimeEvent.TIME_OVER, timeOverHandler);
		}
		
		public function activateInterface():void
		{
			trace("act int");
			popupFinish.visible = false;
			resetInterface();
			this.alpha = 0;
			TweenMax.to(MovieClip(GlobalConfiguration.application.parent).bgDark, 0.5, { autoAlpha:0 } );
			TweenMax.to(this, 0.4, { alpha:1, onComplete:function() {
				GlobalConfiguration.application.gameTimer.evtDispatcher.addEventListener(TimeEvent.TIME_PROGRESS, timeProgressHandler);
				GlobalConfiguration.application.resultsBridge.evtDispatcher.addEventListener(ScoreEvent.CHANGE, scored);
				GlobalConfiguration.application.gameTimer.evtDispatcher.addEventListener(TimeEvent.TIME_OVER, timeOverHandler);
				GlobalConfiguration.application.gameStart();
			} } );
		}
		
		public function deactivateInterface(_nextState:String):void
		{
			//GlobalConfiguration.application.gameTimer.evtDispatcher.removeEventListener(TimeEvent.TIME_PROGRESS, timeProgressHandler);
			//GlobalConfiguration.application.resultsBridge.evtDispatcher.removeEventListener(ScoreEvent.CHANGE, scored);
			//GlobalConfiguration.application.gameTimer.evtDispatcher.removeEventListener(TimeEvent.TIME_OVER, timeOverHandler);
		}
		
		private function removeListeners():void
		{
			GlobalConfiguration.application.gameTimer.evtDispatcher.removeEventListener(TimeEvent.TIME_PROGRESS, timeProgressHandler);
			GlobalConfiguration.application.resultsBridge.evtDispatcher.removeEventListener(ScoreEvent.CHANGE, scored);
			GlobalConfiguration.application.gameTimer.evtDispatcher.removeEventListener(TimeEvent.TIME_OVER, timeOverHandler);
		}
		
		private function timeProgressHandler(e:TimeEvent):void 
		{
		
			labels.timeLabel.txt.text = ""+TimeFormat.intToString(GlobalConfiguration.application.gameTimer.timeRemaining);
		}
		
		private function scored(e:ScoreEvent):void 
		{
			labels.scoreLabel.txt.text = "" + GlobalConfiguration.application.resultsBridge.score;
		}
		
		private function timeOverHandler(e:TimeEvent):void 
		{
			removeListeners();
			GlobalConfiguration.application.gameOver();
			popupFinish.activate();
		}

//--------------------------------------------------------------------------

		
		
	}

}