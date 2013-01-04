package com.boased.ui 
{
	import flash.events.*;
	import flash.display.*;
	
	import com.boased.sprites.IPlayer;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class UserInterface 
	{
		
		public static const MOVEMENT_LEFT:String = "left";
		public static const MOVEMENT_RIGHT:String = "right";
		public static const MOVEMENT_IDLE_LEFT:String = "idleleft";
		public static const MOVEMENT_IDLE_RIGHT:String = "idleright";
		
		private static var userInterface:UserInterface;
		
		public var application:GameContent;
		
		private var currentKeys:Array = new Array();
		
		public static function getInstance(_application:GameContent):UserInterface
		{
			if (userInterface == null)
			{
				userInterface = new UserInterface();
			}
			
			userInterface.application = _application;
			return userInterface;
		}
		
		public function UserInterface() 
		{
			if (userInterface != null)
			{
				throw new Error("UserInterface is a singleton and should not be instantiated. Use getInstance() instead");
			}
		}
		
		
		public function activateInterface():void
		{
			application.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			application.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		public function deactivateInterface():void
		{
			application.player.handleMovement(UserInterface.MOVEMENT_IDLE_RIGHT);
			application.player.handleMovement(UserInterface.MOVEMENT_IDLE_LEFT);
			application.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			application.stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		private function keyUpHandler(e:KeyboardEvent):void 
		{
			var keyPressed:String = "";
			if (e.keyCode == 37 || e.keyCode == 65 || e.keyCode == 100)
			{
				keyPressed = UserInterface.MOVEMENT_IDLE_LEFT;
			}
			if (e.keyCode == 39 || e.keyCode == 68 || e.keyCode == 102)
			{
				keyPressed = UserInterface.MOVEMENT_IDLE_RIGHT;
			}
			
				application.player.handleMovement(keyPressed);
				trace("idle");
				
			
		}
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			var keyPressed:String = "";
			
			if (e.keyCode == 37 || e.keyCode == 65 || e.keyCode == 100)
			{
				keyPressed = UserInterface.MOVEMENT_LEFT;
			}
			if (e.keyCode == 39 || e.keyCode == 68 || e.keyCode == 102)
			{
				keyPressed = UserInterface.MOVEMENT_RIGHT;
			}
			
			application.player.handleMovement(keyPressed);
			
			trace(keyPressed);
		}
		
		
	}

}