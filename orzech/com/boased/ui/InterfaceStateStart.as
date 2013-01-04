package com.boased.ui 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import com.boased.config.GlobalConfiguration;
	import com.boased.ui.GlobalInterfaceFacade;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	
	import flash.media.*;
	import flash.net.*;
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class InterfaceStateStart extends MovieClip implements IInterfaceState
	{
		
		private static const btnsDefY:Number = 614.45;
		
		private var buttons:Array = new Array();
		
		public function GameplayInterface():void
		{
		}
		
		
		public function resetInterface():void
		{
			
		}
		
		public function activateInterface():void
		{
			init();
			for each (var btn:MovieClip in buttons)
			{
				btn.addEventListener(MouseEvent.CLICK, btnClickHandler);
				btn.addEventListener(MouseEvent.MOUSE_OVER, btnOverHandler);
				btn.addEventListener(MouseEvent.MOUSE_OUT, btnOutHandler);
			}
		}
		
		public function deactivateInterface(_nextState:String):void
		{
			for each (var btn:MovieClip in buttons)
			{
				btn.removeEventListener(MouseEvent.CLICK, btnClickHandler);
				btn.removeEventListener(MouseEvent.MOUSE_OVER, btnOverHandler);
				btn.removeEventListener(MouseEvent.MOUSE_OUT, btnOutHandler);
			}
			
			TweenMax.to(this, 0.3, { alpha:0, onComplete:function() {
				GlobalConfiguration.application.globalInterface.deactivate(_nextState);
				}} );
		}

//----------------------------------------------------------------------------------------------------
		
		private function init():void 
		{
			
			popupRanking.visible = false;
			
			
			
			buttons.push(btnStart, btnRanking, btnZasady, btnRegulamin, btnNagrody);
			
			for each (var btn:MovieClip in buttons)
			{
				buttonMode = true;
			}
			
			TweenPlugin.activate([TintPlugin, GlowFilterPlugin]);
		}
		
		
		private function btnClickHandler(e:MouseEvent):void 
		{
			trace(e.currentTarget.name);
			if (GlobalConfiguration.application.soundOn)
			{
			var snd:SoundClick = new SoundClick();
			snd.play();
			}
			switch (e.currentTarget.name)
			{
				case "btnStart": GlobalConfiguration.application.globalInterface.applyInterfaceState(GlobalInterfaceFacade.STATE_GAMEPLAY); break;
				case "btnRanking": showPopupRanking(); break;
				case "btnZasady": showPopupZasady(); break;
				case "btnNagrody": showPopupNagrody(); break;
				case "btnRegulamin": navigateToURL(new URLRequest("http://horalkygames.fbmanager.pl/public/flash/regulamin.pdf"), "_blank"); break;
			}
		}
		
		private function btnOutHandler(e:MouseEvent):void 
		{
			switch (e.currentTarget.name)
			{
				case "btnStart": removeGlow(e.currentTarget); break;
				case "btnRanking": removeGlow(e.currentTarget); break;
				case "btnZasady": removeTint(e.currentTarget); break;
				case "btnRegulamin": removeTint(e.currentTarget); break;
				case "btnNagrody": removeTint(e.currentTarget); break;
				
			}
		}
		
		
		private function btnOverHandler(e:MouseEvent):void 
		{
			if (GlobalConfiguration.application.soundOn)
			{
			var snd:SoundOver = new SoundOver();
			snd.play();
			}
			switch (e.currentTarget.name)
			{
				case "btnStart": applyGlow(e.currentTarget); break;
				case "btnRanking": applyGlow(e.currentTarget); break;
				case "btnZasady": applyTint(e.currentTarget); break;
				case "btnRegulamin": applyTint(e.currentTarget); break;
				case "btnNagrody": applyTint(e.currentTarget); break;
				
			}
		}
		
		private function applyGlow(_currentTarget:Object):void 
		{
			var mc:MovieClip = _currentTarget as MovieClip;
			TweenMax.to(mc, 0.8, { glowFilter: { color:0xffffff, strength:2.5, alpha:1, blurX:20, blurY:20 }} );
			TweenMax.to(mc.label, 0.5, { glowFilter: { color:0xffffff, strength:0.8, alpha:0.6, blurX:6, blurY:6 }} );
		}
		
		private function applyTint(_currentTarget:Object):void 
		{
			var mc:MovieClip = _currentTarget as MovieClip;
			TweenMax.to(mc, 0.3, { y:btnsDefY - 6, tint:0xe6cBa8} );
		}
		
		private function removeGlow(_currentTarget:Object):void 
		{
			var mc:MovieClip = _currentTarget as MovieClip;
			TweenMax.to(mc, 0.4, { glowFilter: { color:0xffffff, strength:0, alpha:0, remove:true, blurX:0, blurY:0 }} );
			TweenMax.to(mc.label, 0.3, { glowFilter:{color:0xffffff, strength:0, alpha:0, remove:true, blurX:0, blurY:0 }} );
		}
		
		private function removeTint(_currentTarget:Object):void 
		{
			var mc:MovieClip = _currentTarget as MovieClip;
			TweenMax.to(mc, 0.3, { y:btnsDefY, removeTint:true} );
		}
		
//----------------------------------------------------------------------------------------------------

		private function showPopupRanking():void
		{
			popupRanking.activate();
		}

		public function hidePopupRanking():void
		{
			popupRanking.visible = false;
		}
	
		private function showPopupZasady():void
		{
			popupZasady.activate();
		}
		
		public function hidePopupZasady():void
		{
			popupZasady.visible = false;
		}
		
		private function showPopupNagrody():void
		{
			popupNagrody.activate();
		}
		
		public function hidePopupNagrody():void
		{
			popupNagrody.visible = false;
		}
	}

}