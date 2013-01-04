package com.boased.sprites 
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	import com.boased.sprites.IPlayer;
	import com.boased.config.GlobalConfiguration;
	import com.boased.events.ScoreEvent;
	import com.boased.business.ResultsBridge;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class Wafelki extends MovieClip implements ISpriteTarget
	{
		
		var recentlyHit:Boolean = false;
		
		public function Wafelki():void
		{
			
		}
		
		public function plant():void
		{
			this.alpha = 0;
			this.scaleX = this.scaleY = 0.1;
			this.visible = true;
			TweenMax.to (this, GlobalConfiguration.COCO_PLANT_TIME, { scaleX:1, scaleY:1, alpha:1, ease:Bounce.easeOut } );
		}
		
		public function destroy():void
		{
			if (GlobalConfiguration.application.soundOn)
					{
					var snd:SoundBonus = new SoundBonus();
						snd.play();
					}
			GlobalConfiguration.application.resultsBridge.updateScore(ResultsBridge.INCREASE_SUPER);
			GlobalConfiguration.application.resultsBridge.evtDispatcher.dispatchEvent(new ScoreEvent(ScoreEvent.CHANGE));
			GlobalConfiguration.application.ball.currentSpeed = GlobalConfiguration.WAFELKI_BONUS_FACTOR;
			TweenMax.to(this, 0.2, { autoAlpha:0 } );
			TweenMax.delayedCall(GlobalConfiguration.COCO_SEED_TIME, plant);
			hitDelay();
		}
		public function activate():void
		{
			this.visible = true;
			this.alpha = 1;
			TweenMax.killDelayedCallsTo(this.plant);
			TweenMax.killTweensOf(this);
			recentlyHit = false;
		}
		
		private function hitDelay():void 
		{
			recentlyHit = true;
			TweenMax.delayedCall(0.5, resetHitDelay);
		}
		
		private function resetHitDelay():void 
		{
			recentlyHit = false;
		}
		
		
		
	}

}