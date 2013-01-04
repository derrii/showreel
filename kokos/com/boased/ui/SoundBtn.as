package com.boased.ui 
{
	import flash.display.MovieClip;
	
	import flash.events.*;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	
	import com.boased.config.GlobalConfiguration;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class SoundBtn extends MovieClip
	{
		
		public function SoundBtn():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			TweenPlugin.activate([TintPlugin, RemoveTintPlugin]);
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, btnClickHandler);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			if (!GlobalConfiguration.application.soundOn)
			{
				TweenMax.to(this, 0, { tint:0xff0000 } );
			}
		}
		
		private function btnClickHandler(e:MouseEvent):void 
		{
			if (GlobalConfiguration.application.soundOn)
			{
				TweenMax.to(this, 0.2, { tint:0xff0000 } );
				GlobalConfiguration.application.musicStatusChange(false);
				GlobalConfiguration.application.soundOn = false;
			} else
			{
				TweenMax.to(this, 0.2, { removeTint:true } );
				GlobalConfiguration.application.musicStatusChange(true);
				GlobalConfiguration.application.soundOn = true;
			}
		}
		
	}

}