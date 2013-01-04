package com.boased.sprites 
{
	import flash.display.MovieClip;
	import flash.media.*;

	import com.boased.config.GlobalConfiguration;
	
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class YellowCoco extends MovieClip implements ISpriteTarget
	{
		
		var sndTransform:SoundTransform = new SoundTransform(0.5);
		var sndChannel:SoundChannel = new SoundChannel();
		
		var recentlyHit:Boolean = false;
		
		public function YellowCoco():void
		{
			
		}
		
		public function plant():void
		{
			
		}
		
		public function destroy():void
		{
			if (GlobalConfiguration.application.soundOn)
					{
					var snd:SoundYellowCoco = new SoundYellowCoco();
							sndChannel = snd.play();
						sndChannel.soundTransform = sndTransform;
					}
			trace("Yellow coco is indestructible");
			hitDelay();
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
		
		public function activate():void
		{
			
		}
		
	}

}