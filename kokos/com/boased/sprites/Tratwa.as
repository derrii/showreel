package com.boased.sprites 
{
	
	import flash.display.*;
	import flash.events.*;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import com.boased.config.GlobalConfiguration;
	import com.boased.ui.UserInterface;


	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class Tratwa extends MovieClip implements IPlayer
	{
		
		public static const ROCK_COLLISION:String = "rockcollision";
		
		private static const ANIM_LEFT:String = "left";
		private static const ANIM_RIGHT:String = "right";
		private static const ANIM_IDLE:String = "idle";
		
		private var movementDirection:String;
		
		private var delta:Number;
		
		private var _stunned:Boolean;
		
		private var _currentSpeed:Number;
		
		private var defaultX:Number;
		private var defaultY:Number;
		
		private var leftMov:Boolean;
		private var rightMov:Boolean;
		
		public function Tratwa():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			init();
		}
		
		private function init():void 
		{
			TweenPlugin.activate([MotionBlurPlugin]);
			defaultX = this.x;
			defaultY = this.y;
			delta = GlobalConfiguration.PLAYER_AUTO_MOVEMENT_MIN_DELTA;
			_stunned = false;
			_currentSpeed = 1;
			
			waterLeft.alpha = 0;
			waterRight.alpha = 0;
			
			//rightAnim.stop();
			addEventListener(Event.ENTER_FRAME, animationRender);
			//addEventListener(GameEvent.ROCK_COLLISION, startStunnedPhase);
		}
		
		
		
		public function handleCollision(_type:String):void 
		{
			/*
			if (_type == Futrzak.ROCK_COLLISION)
			{
				if (GlobalConfiguration.application.soundOn)
				{
				var snd:SoundOuch = new SoundOuch();
					snd.play();
				var snd2:SoundGwiazdki = new SoundGwiazdki();
					snd2.play();
				}		
				_stunned = true;
				animStunned.visible = true;
				animStunned.play();
				rightAnim.visible = false;
				
				
				
				TweenMax.delayedCall(GlobalConfiguration.PLAYER_STUNNED_DURATION, finishStunnedPhase);
			}*/
		}
		
		/*private function finishStunnedPhase():void 
		{
			rightAnim.visible = true;
			animStunned.visible = false;
			animStunned.stop();
			
			_stunned = false;
		}*/
		
		private function animationRender(e:Event):void 
		{
			
			//if (!_stunned)
			//{
				
				//if (movementDirection == UserInterface.MOVEMENT_LEFT)
				if (leftMov)
				{
					if (delta < 1)
					{
						delta += GlobalConfiguration.PLAYER_AUTO_MOVEMENT_DELTA;
					}
					//scaleX = -1;
					//rightAnim.play();
					
					animate(Tratwa.ANIM_LEFT);
					
					if (x > GlobalConfiguration.STAGE_PADDING_LEFT)
					{
					//	x -= (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed);
					if (_currentSpeed > 1)
						{
							TweenMax.to(this, 0.05, { motionBlur:true, x:x - (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed) } );
						} else
						{
							TweenMax.to(this, 0.05, { motionBlur:false, x:x - (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed) } );
						}
					}
				}
				if (rightMov)
				{
					if (delta < 1)
					{
						delta += GlobalConfiguration.PLAYER_AUTO_MOVEMENT_DELTA;
					}
					//scaleX = 1;
					//rightAnim.play();
					animate(Tratwa.ANIM_RIGHT);
					
					if (x < GlobalConfiguration.STAGE_PADDING_RIGHT)
					{
					//	x += (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed);
					if (_currentSpeed > 1)
						{
							TweenMax.to(this, 0.05, { motionBlur:true, x:x + (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed) } );
						} else
						{
							TweenMax.to(this, 0.05, { x:x + (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed) } );
						}
					}
				}
				if (!rightMov && !leftMov)
				{
					delta = GlobalConfiguration.PLAYER_AUTO_MOVEMENT_MIN_DELTA;
					animate(Tratwa.ANIM_IDLE);
					rightAnim.stop();
				}
			/*} else
			{
				animStunned.visible = true;
			}*/
			
		}
		
		private function animate(_direction:String):void 
		{
			
			if (_direction == Tratwa.ANIM_LEFT)
			{
				if (waterLeft.alpha > 0) {waterLeft.alpha -= 0.1}
				if (waterRight.alpha < 1) { waterRight.alpha += 0.2 }
				
				if (rightAnim.currentFrame > 1)
				{ 
					rightAnim.prevFrame();
				} else
				{
					rightAnim.gotoAndStop(rightAnim.totalFrames);
				}
			} else if (_direction == Tratwa.ANIM_RIGHT)
			{
				if (waterLeft.alpha < 1) {waterLeft.alpha += 0.2}
				if (waterRight.alpha > 0) { waterRight.alpha -= 0.1 }
				
				
				if (rightAnim.currentFrame < rightAnim.totalFrames)
				{
					rightAnim.nextFrame();
				} else
				{
					rightAnim.gotoAndStop(1);
				}
			} else if (_direction == Tratwa.ANIM_IDLE)
			{
				if (waterLeft.alpha > 0) {waterLeft.alpha -= 0.1}
				if (waterRight.alpha > 0) {waterRight.alpha -= 0.2}
			}
		}
		
		public function handleMovement(_direction:String):void
		{
			movementDirection = _direction;
			
			switch (_direction)
			{
				case UserInterface.MOVEMENT_LEFT: leftMov = true; break;
				case UserInterface.MOVEMENT_RIGHT: rightMov = true; break;
				case UserInterface.MOVEMENT_IDLE_LEFT: leftMov = false; break;
				case UserInterface.MOVEMENT_IDLE_RIGHT: rightMov = false; break;
			}
		}
		
		public function get hitter():MovieClip
		{
			return _hitter;
		}
		
		public function get stunned():Boolean
		{
			return _stunned;
		}
		
		public function get leftBound():Number
		{
			var bound:Number;
			if (movementDirection == UserInterface.MOVEMENT_RIGHT)
			{
				bound = this.x;
			} else
			{
				bound = this.x - this.width;
			}
			
			return bound;
		}
		
		public function get rightBound():Number
		{
			var bound:Number;
			if (movementDirection == UserInterface.MOVEMENT_RIGHT)
			{
				bound = this.x + this.width;
			} else
			{
				bound = this.x;
			}
			
			return bound;
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
		
		public function resetToDefaultPosition():void
		{
			this.x = defaultX;
			this.y = defaultY;
		}

		
		
	}

}