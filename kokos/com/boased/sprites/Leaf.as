package com.boased.sprites 
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
	public class Leaf extends MovieClip implements ISprite
	{
		
		public function randomizeLocation():void
		{
			this.x = GlobalConfiguration.STAGE_PADDING_LEFT + Math.random() * 
					 GlobalConfiguration.STAGE_PADDING_RIGHT;
			
			this.y = GlobalConfiguration.LEAF_TOP_MARGIN+Math.random()*(GlobalConfiguration.LEAF_BOTTOM_MARGIN-GlobalConfiguration.LEAF_TOP_MARGIN);
		}
		
		public function Leaf():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			TweenPlugin.activate([TransformAroundPointPlugin, TransformAroundCenterPlugin, ShortRotationPlugin]);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			leafAnim.stop();
			init();
		}
		
		private function init():void 
		{
			this.scaleX = this.scaleY = 0.7;
			this.alpha = 0;
			
			TweenMax.to(this, 0, { rotationX:90 * Math.random(), rotationY:90*Math.random(), rotationZ:GlobalConfiguration.LEAF_ROTATION_MARGIN * 3 - 30 } );			
		}
		
		public function lifeCycleStart():void 
		{
			var _this:* = this;
			leafAnim.play();
			TweenMax.to(this, GlobalConfiguration.LEAF_FALL_TIME/2, { alpha:1, onComplete:function() {
				TweenMax.to(_this, GlobalConfiguration.LEAF_FALL_TIME/2, { alpha:0 } );
				} } );
			var signRnd:Number = Math.random();
			var sign:Number;
			if (signRnd > 0.5)
			{
				sign = -1;
			} else
			{
				sign = 1;
			}
			TweenMax.to(this, GlobalConfiguration.LEAF_FALL_TIME, { x:x + GlobalConfiguration.LEAF_FALL_MARGIN*sign, y:y+ GlobalConfiguration.LEAF_BOTTOM_MARGIN,ease:Back.easeIn
			, onComplete:destroy} );
			
		}
		
		private function destroy():void
		{
			try
			{
				leafAnim.stop();
				MovieClip(this.parent).removeChild(this);
			} catch (e:Error)
			{
				//
			}
			
		}
		
	}

}