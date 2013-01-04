package com.boased.ui 
{
	import flash.display.*;
	import flash.events.*;
	import com.boased.config.GlobalConfiguration;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class FsBtn extends MovieClip
	{
		
		public function FsBtn():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, btnClickHandler);
			
		}
		
		private function btnClickHandler(e:MouseEvent):void 
		{
			trace("clicked");
			trace("" + GlobalConfiguration.stageReference.stageWidth);
			if (GlobalConfiguration.stageReference.displayState == StageDisplayState.NORMAL) {	
				trace("ahoj");
				GlobalConfiguration.stageReference.displayState = StageDisplayState.FULL_SCREEN;
				
			} else {
				trace("bejoj");
				GlobalConfiguration.stageReference.displayState = StageDisplayState.NORMAL;
			}
		}
		
	}

}