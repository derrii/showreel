package com.boased.sprites 
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;

	import com.boased.config.GlobalConfiguration;
	import com.boased.events.ScoreEvent;
	import com.boased.business.ResultsBridge;

	import flash.media.*;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class Coco extends MovieClip implements ISpriteTarget
	{

		var sndTransform:SoundTransform = new SoundTransform(0.8);
		var sndChannel:SoundChannel = new SoundChannel();
		
		var recentlyHit:Boolean = false;
		
		public function Coco():void
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
					
					var snd:SoundCoco = new SoundCoco();
						
						sndChannel = snd.play();
						sndChannel.soundTransform = sndTransform;
					}
			
			if (getQualifiedClassName(this) == "CocoHalf")
			{
				GlobalConfiguration.application.resultsBridge.updateScore(ResultsBridge.INCREASE);
			} else
			{
				GlobalConfiguration.application.resultsBridge.updateScore(ResultsBridge.INCREASE_FULL);
			}
			GlobalConfiguration.application.resultsBridge.evtDispatcher.dispatchEvent(new ScoreEvent(ScoreEvent.CHANGE));
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