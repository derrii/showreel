package com.boased.ui 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import com.boased.ui.IInterfaceState;
	import com.boased.config.GlobalConfiguration;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class GlobalInterfaceFacade extends MovieClip
	{
		
		public static const STATE_GAMEPLAY:String = "gameplay";
		public static const STATE_START:String = "gamestart";
		
		private var currentInterface:IInterfaceState;
		
		public function GlobalInterfaceFacade():void
		{
			
		}
		
		public function applyInterfaceState(_state:String):void
		{
			if (currentInterface != null)
			{
				currentInterface.deactivateInterface(_state);
			} else
			{
				var iState:Class;
				switch (_state)
				{
					case GlobalInterfaceFacade.STATE_GAMEPLAY: iState = InterfaceStateGameplay; break;
					case GlobalInterfaceFacade.STATE_START: iState = InterfaceStateStart; break;
				}
				
				currentInterface = new iState();
				addChild(currentInterface as DisplayObject);
			}
		}
		
		public function resetInterface():void
		{
			currentInterface.resetInterface();
		}
		
		public function activate():void
		{
			currentInterface.activateInterface();
		}

		public function deactivate(_nextState:String):void
		{
			removeChild(currentInterface as DisplayObject);
			currentInterface = null;
			applyInterfaceState(_nextState);
			activate();
		}
		
		public function get activeInterface():IInterfaceState
		{
			return currentInterface;
		}
		
		
	}

}