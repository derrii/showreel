package com.boased.ui 
{
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public interface IInterfaceState 
	{

		function resetInterface():void
		
		function activateInterface():void
		function deactivateInterface(_nextState:String):void
		
	}
	
}