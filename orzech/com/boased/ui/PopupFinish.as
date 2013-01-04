package com.boased.ui 
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;

	import com.boased.config.GlobalConfiguration;

	import com.boased.events.AMFEvent;
	import com.boased.services.AMFConnector;

	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class PopupFinish extends MovieClip
	{

		public var evtDispatcher:EventDispatcher = new EventDispatcher();
		
		public function PopupFinish() 
		{
			
		}
		
		public function activate():void
		{
			init();
			txtPoints.text = GlobalConfiguration.application.resultsBridge.score.toString();
			popupRanking.visible = false;
			retrieveAMFData();
			TweenMax.to(this, 0.4, { alpha:1 } );
		}
		
		public function retrieveAMFData():void
		{
			evtDispatcher.addEventListener(AMFEvent.RECIEVED, rankUpdatedHandler);
			AMFConnector.updateRank(this, GlobalConfiguration.application.fbId, 
									GlobalConfiguration.application.oFaceBookConnector.UserInfo.UserName, 
									GlobalConfiguration.application.resultsBridge.score.toString(),									
									"1");
		}
		
		private function rankUpdatedHandler(e:AMFEvent):void 
		{
			this.visible = true;
			evtDispatcher.removeEventListener(AMFEvent.RECIEVED, rankUpdatedHandler);
			btnStart.addEventListener(MouseEvent.CLICK, btnClickHandler);
			btnStart.addEventListener(MouseEvent.MOUSE_OVER, btnOverHandler);
			btnStart.addEventListener(MouseEvent.MOUSE_OUT, btnOutHandler);
			btnRanking.addEventListener(MouseEvent.CLICK, btnClickHandler);
			btnRanking.addEventListener(MouseEvent.MOUSE_OVER, btnOverHandler);
			btnRanking.addEventListener(MouseEvent.MOUSE_OUT, btnOutHandler);
			GlobalConfiguration.application.oFaceBookConnector.postToWallUI(this);
		}
		
		public function handlePostResults(resp:Object):void
		{
			trace("posted");
		}
		
		private function init():void 
		{
			btnStart.buttonMode = true;
			btnRanking.buttonMode = true;
		}
		
		
		private function deactivate():void
		{
			btnStart.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			btnStart.removeEventListener(MouseEvent.MOUSE_OVER, btnOverHandler);
			btnStart.removeEventListener(MouseEvent.MOUSE_OUT, btnOutHandler);
			btnRanking.removeEventListener(MouseEvent.CLICK, btnClickHandler);
			btnRanking.removeEventListener(MouseEvent.MOUSE_OVER, btnOverHandler);
			btnRanking.removeEventListener(MouseEvent.MOUSE_OUT, btnOutHandler);
			
		}
		
//-------------------------------------------------

		private function btnOverHandler(e:Event):void 
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			TweenMax.to(mc, 0.8, { glowFilter: { color:0xffffff, strength:2.5, alpha:1, blurX:20, blurY:20 }} );
			TweenMax.to(mc.label, 0.5, { glowFilter: { color:0xffffff, strength:0.8, alpha:0.6, blurX:6, blurY:6 }} );
		}
		
		private function btnOutHandler(e:Event):void 
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			TweenMax.to(mc, 0.4, { glowFilter: { color:0xffffff, strength:0, alpha:0, remove:true, blurX:0, blurY:0 }} );
			TweenMax.to(mc.label, 0.3, { glowFilter:{color:0xffffff, strength:0, alpha:0, remove:true, blurX:0, blurY:0 }} );
		}
		
		private function btnClickHandler(e:MouseEvent):void 
		{
			switch (e.currentTarget.name)
			{
				case "btnStart": resetGame(); break;
				case "btnRanking": showPopupRanking(); break;
			}
		}
		
		private function resetGame():void
		{
			var _this:* = this;
			MovieClip(GlobalConfiguration.application.parent).bgDark.visible = true;
			MovieClip(GlobalConfiguration.application.parent).bgDark.alpha = 1;
			GlobalConfiguration.application.restartGame();
			TweenMax.to(this, 0.3, { alpha:0 , onComplete:function() {
				_this.visible = false;
				TweenMax.to(MovieClip(GlobalConfiguration.application.parent).bgDark, 0.4, { autoAlpha:0, onComplete:function() {
				GlobalConfiguration.application.gameStart();
			}} );
			}});
		}
		
		private function showPopupRanking():void
		{
			popupRanking.activate();
		}

		public function hidePopupRanking():void
		{
			popupRanking.visible = false;
		}
		
		
	}

}