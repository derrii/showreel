package com.boased.sprites 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public interface IPlayer 
	{
		
		function handleMovement(_direction:String):void
		function handleCollision(_type:String):void
		function get hitter():MovieClip
		function get stunned():Boolean
		function set currentSpeed(value:Number):void
		function resetToDefaultPosition():void
		
		function get leftBound():Number;
		function get rightBound():Number;
		
	}
	
}