package com.boased.ui 
{
	import flash.display.MovieClip;
	
	import com.boased.config.GlobalConfiguration;
	import com.boased.utils.TimeFormat;
	
	import com.boased.events.ScoreEvent;
	import com.boased.events.LifeEvent;

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
			
			scoreLabel.label.txt.text = GlobalConfiguration.DEFAULT_SCORE;
			
			GlobalConfiguration.application.resultsBridge.evtDispatcher.addEventListener(ScoreEvent.CHANGE, scored);
			GlobalConfiguration.application.lifeManager.evtDispatcher.addEventListener(LifeEvent.GAME_LOST, gameOverHandler);				
		}
		
		public function activateInterface():void
		{
			trace("act int");
			popupFinish.visible = false;
			resetInterface();
			//this.x = 115;
			//this.y = 640;
			this.alpha = 0;
			//TweenMax.to(MovieClip(GlobalConfiguration.application.parent).bgDark, 0.5, { autoAlpha:0 } );
			TweenMax.to(this, 0.4, { alpha:1, onComplete:function() {
				
				GlobalConfiguration.application.resultsBridge.evtDispatcher.addEventListener(ScoreEvent.CHANGE, scored);
				GlobalConfiguration.application.lifeManager.evtDispatcher.addEventListener(LifeEvent.GAME_LOST, gameOverHandler);				
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
			GlobalConfiguration.application.resultsBridge.evtDispatcher.removeEventListener(ScoreEvent.CHANGE, scored);
			GlobalConfiguration.application.lifeManager.evtDispatcher.removeEventListener(LifeEvent.GAME_LOST, gameOverHandler);				
				
		}
		
		private function scored(e:ScoreEvent):void 
		{
			trace("scr add2");
			scoreLabel.label.txt.text = "" + GlobalConfiguration.application.resultsBridge.score;
		}
		
		private function gameOverHandler(e:LifeEvent):void 
		{
			removeListeners();
			//GlobalConfiguration.application.gameOver();
			popupFinish.activate();
		}

//--------------------------------------------------------------------------

		
		
	}

}