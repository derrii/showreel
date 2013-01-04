package com.boased.sprites 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.*;
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;

	import com.boased.config.GlobalConfiguration;
	import com.boased.business.ResultsBridge;

	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class Peanut extends MovieClip implements ISprite
	{
		
		public var position:int;
		
		public var defaultX:Number;
		public var defaultY:Number;
		
		public static const LEFT_SIDE:int = 1;
		public static const RIGHT_SIDE:int = -1;
		
		public var side:int;
		
		public var rolling:Boolean;
		
		
		public function randomizeLocation():void
		{
			
			var loc:int = 1 + Math.floor(Math.random() * (GlobalConfiguration.PEANUTS_HOLDERS_COUNT-1));
			if (GlobalConfiguration.application.peanutHolders[loc] != null)
			{
				this.randomizeLocation();
			} else
			{
				this.x = GlobalConfiguration.application.peanutHoldersLoc[loc].x;
				this.y = GlobalConfiguration.application.peanutHoldersLoc[loc].y;
				trace("success, placed at pos " + loc);
				GlobalConfiguration.application.peanutHolders[loc] = this;
			}
			var sideRnd:Number = Math.random();
			if (sideRnd < 0.5)
			{
				side = Rock.LEFT_SIDE;
			} else
			{
				side = Rock.RIGHT_SIDE;
			}
		}
		
		public function Peanut():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			TweenPlugin.activate([TransformAroundPointPlugin, TransformAroundCenterPlugin, ShortRotationPlugin]);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			peanutAnim.stop();
			init();
		}
		
		private function init():void 
		{
			TweenMax.to(this, 0, { transformAroundCenter: { scale:0.2 }} );
			TweenMax.to(this, 0, { rotationX:20 * Math.random(), rotationY:20*Math.random(), rotationZ:GlobalConfiguration.PEANUT_ROTATION_MARGIN * 3 - 30 } );
			
			// developementStage
			
			rolling = false;
		}
		
		public function lifeCycleStart():void 
		{
			TweenMax.to(this, GlobalConfiguration.PEANUT_HANG_TIME,  { transformAroundCenter: { scale:1}, ease:Linear.easeNone, onComplete:function() {
			animFall();	
				}} );
			
		}
		
		private function animFall():void
		{
			var _this:* = this;
			peanutAnim.play();
			this.addEventListener(Event.ENTER_FRAME, oef);
			TweenMax.to(_this, GlobalConfiguration.PEANUT_FALL_TIME, { y:y + GlobalConfiguration.PEANUT_FALL_MARGIN, ease:Quart.easeIn, onComplete:function()
			{
				//_this.destroy(false);
			}
			
			} );
		}
		
		public function oef(e:Event):void 
		{
			if (!this.rolling)
			{
				if (!GlobalConfiguration.application.player.stunned && this.hitTestObject(GlobalConfiguration.application.player.hitter as DisplayObject))
				{
					if (GlobalConfiguration.application.soundOn)
					{
					var snd:SoundKoszyk = new SoundKoszyk();
					snd.play();
					}
					GlobalConfiguration.application.resultsBridge.updateScore(ResultsBridge.INCREASE);
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
		
		public function destroy(_scored:Boolean):void 
		{
			try{
				TweenMax.killTweensOf(this, false);
				peanutAnim.stop();
				this.visible = false;
				GlobalConfiguration.application.peanutHolders[GlobalConfiguration.application.peanutHolders.indexOf(this)] = null;
			} catch (e:Error)
			{
				//
			}
			
		}
		
		
	}

}