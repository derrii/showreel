package com.boased.sprites 
{
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	
	import flash.events.Event;
	import flash.display.*;
	
	import com.greensock.TweenMax;
	import com.boased.config.GlobalConfiguration;
	import com.boased.business.ResultsBridge;
 
	public class SuperPeanut extends Peanut implements ISprite
	{
		
		public function SuperPeanut() 
		{
			super();
			peanutAnim = this.peanutAnim2;
		}

		override public function oef(e:Event):void 
		{
			if (!this.rolling)
			{
				if (!GlobalConfiguration.application.player.stunned && this.hitTestObject(GlobalConfiguration.application.player.hitter as DisplayObject))
				{
					if (GlobalConfiguration.application.soundOn)
					{
					var snd:SoundTurbo = new SoundTurbo();
					snd.play();
					}
					GlobalConfiguration.application.resultsBridge.updateScore(ResultsBridge.INCREASE_SUPER);
					GlobalConfiguration.application.player.currentSpeed = 1.5;
					//this.destroy(true);
					this.removeEventListener(Event.ENTER_FRAME, oef);
					GlobalConfiguration.application.swapChildWithPlayer(this);
					TweenMax.delayedCall(0.05, destroy, [true]);
				}
				if (this.y >= GlobalConfiguration.STAGE_GROUND_LEVEL-peanutAnim.height)
					{
						trace("peanut on ground!");
						
						TweenMax.killTweensOf(this);
						this.rolling = true;
						peanutAnim.stop();
						TweenMax.to(this, 1, { x:x + (30 * side) } );
						var _this:* = this;
						TweenMax.to(this, 0.4, { delay:0.6, alpha:0, onComplete:function()
						{_this.destroy(false)}
							} );
					}
			} else
			{
				peanutAnim.prevFrame();
			}
		}
		
	}

}