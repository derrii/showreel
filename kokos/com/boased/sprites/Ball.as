package com.boased.sprites 
{
	import flash.display.*;
	import flash.events.*;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;

	import com.boased.config.GlobalConfiguration;
	
	import com.boased.utils.PixelPerfectCollision;
	
	import flash.media.*;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class Ball extends MovieClip implements ISprite
	{
		
		public var speedX:Number = 0;
		public var speedY:Number = 15;
		
		public var defaultX:Number;
		public var defaultY:Number;
		
		public static const COLLISION_PADDLE:String = "paddle";
		
		private var _currentSpeed:Number = 1;
		
		private var ballFailed:Boolean = false;
		
		var sndTransform:SoundTransform = new SoundTransform(0.2);
		var sndChannel:SoundChannel = new SoundChannel();
		
		
		public function Ball():void
		{
			TweenPlugin.activate([MotionBlurPlugin]);
			this.visible = false;
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			defaultX = this.x;
			defaultY = this.y;
		}
		
		public function randomizeLocation():void
		{
			//
		}
		
		public function lifeCycleStart():void
		{
			ballFailed = false;
			addEventListener(Event.ENTER_FRAME, render);
			
		}
		
		private function render(e:Event):void 
		{
			if (!ballFailed)
			{
				
				
				TweenMax.to(this, 0, { x:this.x + (speedX*_currentSpeed), y:this.y + (speedY*_currentSpeed), ease:Linear.easeNone } );
				
				if (this.x >= GlobalConfiguration.STAGE_PADDING_RIGHT + this.width)	{ this.x = GlobalConfiguration.STAGE_PADDING_RIGHT - 2 ; speedX *= -1 }
				if (this.x <= GlobalConfiguration.STAGE_PADDING_LEFT)	{ this.x = GlobalConfiguration.STAGE_PADDING_LEFT + 2;  speedX *= -1 }
				if (this.y <= GlobalConfiguration.STAGE_PADDING_TOP)	{ speedX = Math.random() * 16 - 8;  this.y += 10; speedY *= -1 }
				if (this.y >= GlobalConfiguration.STAGE_GROUND_LEVEL - this.height)	{ handleBallFail() }
				
				if (this.hitTestObject(GlobalConfiguration.application.player.hitter as DisplayObject))
				{
					handleCollision(Ball.COLLISION_PADDLE);
				}
				
				for (var i:int = 1 ; i <= GlobalConfiguration.COCO_HOLDERS_COUNT ; i++)
				{
					if (this.hitTestObject(GlobalConfiguration.application["o" + i]) && GlobalConfiguration.application["o" + i].visible
					&& !GlobalConfiguration.application["o" + i].recentlyHit)
					{
						GlobalConfiguration.application["o" + i].destroy();
						TweenMax.killTweensOf(this);
						
						this.x -= speedX;
						this.y -= speedY;
						
						var rnd2:Number = Math.random() * 2 - 1;
						speedY *= -1;
						speedX *= rnd2;
						
					}
				}
				
			}
			
		}
		
		private function handleBallFail():void 
		{
			// ball fail
			
			ballFailed = true;
			if (GlobalConfiguration.application.soundOn)
					{
					var snd:SoundPlusk = new SoundPlusk();
						snd.play();
					}
			GlobalConfiguration.application.plusk.setAndPlay(this.x - 40, this.y - 40);
			
			TweenMax.delayedCall(2, handleBallLost);
			
		}
		
		private function handleBallLost():void 
		{
			
			this.visible = false;
			resetBallProps();
			GlobalConfiguration.application.lifeManager.lifeLost();
			
		}
		
		public function resetBallProps():void 
		{
			speedX = 0;
			speedY = 15;
			resetSpeed();
			this.x = defaultX;
			this.y = defaultY;
			
		}
		
		private function handleCollision(_collisionType:String):void 
		{
			if (_collisionType == Ball.COLLISION_PADDLE)
			{
				if (GlobalConfiguration.application.soundOn)
					{
					var snd:SoundTratwa = new SoundTratwa();
						sndChannel = snd.play();
						sndChannel.soundTransform = sndTransform;
					}
				calculateNewAngle();
				this.y = 640;
			}
		}
		
		private function calculateNewAngle():void 
		{
			var ballPosition:Number = this.x - (DisplayObject(GlobalConfiguration.application.player).x + GlobalConfiguration.application.player.hitter.x);
			var hitPercent:Number = (ballPosition / (GlobalConfiguration.application.player.hitter.width -
									this.width)) - .5;
			
			speedX = hitPercent * 24;
			speedY *= -1;
		}
		
		public function set currentSpeed(value:Number):void 
		{
			
			_currentSpeed = value;
			TweenMax.killDelayedCallsTo(resetSpeed);
			TweenMax.delayedCall(GlobalConfiguration.WAFELKI_BONUS_DURATION, resetSpeed);
		}
		
		private function resetSpeed():void
		{
			_currentSpeed = 1;
			
		}
		
		
	}

}