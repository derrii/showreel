package com.boased.business 
{
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public interface IResultsBridge 
	{
		
		function get score():Number
		function set score(_value:Number):void
		
		function updateScore(_type:String):void
		
	}
	
}