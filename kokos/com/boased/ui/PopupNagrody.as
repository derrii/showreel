package com.boased.ui 
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	
	import com.boased.config.GlobalConfiguration;
	
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class PopupNagrody extends MovieClip
	{
		
		private var defaultY:Number;
		
		public function PopupNagrody():void
		{
			defaultY = this.y;
			this.y += this.height+50;
		}
		
		public function init():void
		{
			TweenPlugin.activate([ShortRotationPlugin, TransformAroundPointPlugin, TransformAroundCenterPlugin]);
			
			btnClose.buttonMode = true;
			btnClose2.buttonMode = true;
			TweenMax.to(btnClose2, 0, { scaleX:0.6, scaleY:0.6 } );
			alpha = 0;
			labels.alpha = 0;
			visible = true;
		}
		
		public function activate():void
		{
			init();
			if (GlobalConfiguration.application.soundOn)
			{
			var snd:SoundDolne = new SoundDolne();
					snd.play();
			}		
			TweenMax.to(this, 0.4, { alpha:1 } );
			TweenMax.to(this, 0.8, { y:defaultY , ease:Elastic.easeOut } );
			TweenMax.to(labels, 0.3, { delay: 0.7, alpha:1 } );
			btnClose.addEventListener(MouseEvent.CLICK, btnCloseClickHandler);
			btnClose2.addEventListener(MouseEvent.CLICK, btnCloseClickHandler);
			btnClose2.addEventListener(MouseEvent.MOUSE_OVER, btnCloseOverHandler);
			btnClose2.addEventListener(MouseEvent.MOUSE_OUT, btnCloseOutHandler);
		}
		
		private function deactivate():void
		{
			btnClose.removeEventListener(MouseEvent.CLICK, btnCloseClickHandler);
			MovieClip(parent).hidePopupNagrody();	
		}
		
//-------------------------------------------------
		
		private function btnCloseClickHandler(e:MouseEvent):void 
		{
			var _this:* = this;
			TweenMax.to(labels, 0.2, { alpha:0 } );
			TweenMax.to(this, 0.5, { delay:0.1, y:(defaultY+this.height+50)} );
			TweenMax.to(this, 0.4, { delay:0.3, alpha:0, onComplete:function() {
			_this.deactivate();
			}});
		}

		private function btnCloseOutHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, 0.2, { scaleX:0.6, scaleY:0.6 } );
		}
		
		private function btnCloseOverHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, 0.1, { scaleX:0.8, scaleY:0.8 } );
		}
		
		
		
	}

}