package com.boased.sprites 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;

	import com.boased.config.GlobalConfiguration;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class Rock extends MovieClip implements ISprite
	{
		
		public static const LEFT_SIDE:int = 1;
		public static const RIGHT_SIDE:int = -1;
		
		public var side:int;
		
		private var rolling:Boolean;

		private var evtDispatcher:EventDispatcher = new EventDispatcher();
		
		public function Rock():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			TweenPlugin.activate([PhysicsPropsPlugin]);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			init();
		}
		
		private function init():void 
		{
			rolling = false;
		}
		
		public function randomizeLocation():void
		{
			TweenMax.to(this, 0, { rotationZ:Math.random()*180 } );
			this.y = GlobalConfiguration.ROCK_TOP_BOUNDARY + Math.random() * (GlobalConfiguration.ROCK_BOTTOM_BOUNDARY - GlobalConfiguration.ROCK_TOP_BOUNDARY);
			var sideRnd:Number = Math.random();
			if (sideRnd < 0.5)
			{
				side = Rock.LEFT_SIDE;
				x = GlobalConfiguration.STAGE_PADDING_LEFT - 60;
			} else
			{
				side = Rock.RIGHT_SIDE;
				x = GlobalConfiguration.STAGE_PADDING_RIGHT + 60;
			}
		}
		
		public function lifeCycleStart():void
		{
			this.addEventListener(Event.ENTER_FRAME, oef);
			
			TweenMax.to(this, 3, { physicsProps: { x: { velocity:130 * side, acceleration:50 }, y: { velocity: -260, acceleration:300 }},
			onComplete:destroy});
			
		}
		
		
		private function oef(e:Event):void 
		{
			
			this.rotation += GlobalConfiguration.ROCK_SPIN * side;
			if (!rolling)
			{
				if (this.hitTestObject(GlobalConfiguration.application.player as DisplayObject))
				{
					playerHitHandler();
				}
				
				if (this.y >= GlobalConfiguration.STAGE_GROUND_LEVEL)
				{
					trace("rock ground!");
					if (GlobalConfiguration.application.soundOn)
					{
					var snd:SoundKamien = new SoundKamien();
						snd.play();
					}
					TweenMax.killTweensOf(this);
					this.rolling = true;
					TweenMax.to(this, 1, { x:x + (40 * side)} );
					TweenMax.to(this, 0.6, { delay:0.7, alpha:0, onComplete:destroy } );
				}
			}
			
			
		}
		
		private function playerHitHandler():void 
		{
			destroy();
			TweenMax.killTweensOf(this);
			TweenMax.to(this, 0.3, { alpha:0 } );
			GlobalConfiguration.application.player.handleCollision(Futrzak.ROCK_COLLISION);
			trace("ała");
			
		}
		
		private function destroy():void
		{
			try {
				this.removeEventListener(Event.ENTER_FRAME, oef);
				//MovieClip(this.parent).removeChild(this);
			} catch (e:Error)
			{
				//
			}
		}
		
		
	}

}