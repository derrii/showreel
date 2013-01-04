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
	public class Futrzak extends MovieClip implements IPlayer
	{
		
		public static const ROCK_COLLISION:String = "rockcollision";
		
		private var movementDirection:String;
		
		private var delta:Number;
		
		private var _stunned:Boolean;
		
		private var _currentSpeed:Number;
		
		private var defaultX:Number;
		private var defaultY:Number;
		
		private var leftMov:Boolean;
		private var rightMov:Boolean;

		public var movementTween:TweenMax;
		
		public function Futrzak():void
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
			TweenPlugin.activate([BlurFilterPlugin]);
			defaultX = this.x;
			defaultY = this.y;
			delta = GlobalConfiguration.PLAYER_AUTO_MOVEMENT_MIN_DELTA;
			_stunned = false;
			_currentSpeed = 1;
			animStunned.stop();
			animStunned.visible = false;
			rightAnim.stop();
			addEventListener(Event.ENTER_FRAME, animationRender);
			//addEventListener(GameEvent.ROCK_COLLISION, startStunnedPhase);
		}
		
		
		
		public function handleCollision(_type:String):void 
		{
			if (_type == Futrzak.ROCK_COLLISION)
			{
				if (GlobalConfiguration.application.soundOn)
				{
				var snd:SoundOuch = new SoundOuch();
					snd.play();
				var snd2:SoundGwiazdki = new SoundGwiazdki();
					snd2.play();
				}		
				movementTween = TweenMax.to(this, 0, { blurFilter: { remove:true }} );
				_stunned = true;
				animStunned.visible = true;
				animStunned.play();
				rightAnim.visible = false;
				
				
				
				TweenMax.delayedCall(GlobalConfiguration.PLAYER_STUNNED_DURATION, finishStunnedPhase);
			}
		}
		
		private function finishStunnedPhase():void 
		{
			rightAnim.visible = true;
			animStunned.visible = false;
			animStunned.stop();
			
			_stunned = false;
		}
		
		private function animationRender(e:Event):void 
		{
			if (!_stunned)
			{
				rightAnim.visible = true;
				//if (movementDirection == UserInterface.MOVEMENT_LEFT)
				if (leftMov)
				{
					if (delta < 1)
					{
						delta += GlobalConfiguration.PLAYER_AUTO_MOVEMENT_DELTA;
					}
					scaleX = -1;
					rightAnim.play();
					if (x > GlobalConfiguration.STAGE_PADDING_LEFT)
					{
					//	x -= (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed);
					if (_currentSpeed > 1)
						{
							movementTween = TweenMax.to(this, 0.05, { blurFilter:{blurX:10}, x:x - (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed) } );
						} else
						{
							//movementTween.killVars( { motionBlur:true } );
							movementTween = TweenMax.to(this, 0.05, { blurFilter:{remove:true}, x:x - (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed) } );
						}
					}
				}
				if (rightMov)
				{
					if (delta < 1)
					{
						delta += GlobalConfiguration.PLAYER_AUTO_MOVEMENT_DELTA;
					}
					scaleX = 1;
					rightAnim.play();
					if (x < GlobalConfiguration.STAGE_PADDING_RIGHT)
					{
					//	x += (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed);
					if (_currentSpeed > 1)
						{
							movementTween = TweenMax.to(this, 0.05, { blurFilter:{blurX:10}, x:x + (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed) } );
						} else
						{
							//movementTween.killVars( { motionBlur:true } );
							movementTween = TweenMax.to(this, 0.05, { blurFilter:{remove:true}, x:x + (GlobalConfiguration.PLAYER_AUTO_MOVEMENT_STEP * delta * _currentSpeed) } );
						}
					}
				}
				if (!rightMov && !leftMov)
				{
					delta = GlobalConfiguration.PLAYER_AUTO_MOVEMENT_MIN_DELTA;
					rightAnim.stop();
					movementTween = TweenMax.to(this, 0, { blurFilter: { remove:true }} );
				}
			} else
			{
				animStunned.visible = true;
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
			TweenMax.delayedCall(GlobalConfiguration.SUPER_PEANUT_DURATION, resetSpeed);
		}
		
		private function resetSpeed():void
		{
			_currentSpeed = 1;
			movementTween = TweenMax.to(this, 0, { blurFilter: { remove:true }} );
		}
		
		public function resetToDefaultPosition():void
		{
			this.x = defaultX;
			this.y = defaultY;
		}

		
		
	}

}