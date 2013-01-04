package  
{
	
	import flash.events.*;
	import flash.display.*;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	
	import com.boased.ui.UserInterface;
	import com.boased.sprites.IPlayer;
	import com.boased.config.GlobalConfiguration;
	import com.boased.ui.GlobalInterfaceFacade;
	import com.boased.business.GameTimer;
	
	import com.boased.business.ResultsBridge;
	
	import com.boased.business.LifeManager;
	import com.boased.ui.LifesContainer;
	import com.boased.ui.InterfaceStateGameplay;
	
	import com.boased.services.AMFConnector;
	import com.boased.events.AMFEvent;
	import com.boased.business.UserRank;
	
	
	import flash.media.*;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class GameContent extends MovieClip
	{
	
		public var userInterface:UserInterface;
		public var resultsBridge:ResultsBridge;
		public var gameTimer:GameTimer;
		public var lifeManager:LifeManager;
		
		
		public var globalInterface:GlobalInterfaceFacade;
		
		
		public var player:IPlayer;
		
		public var evtDispatcher:EventDispatcher = new EventDispatcher();
		
		public var sndChannel:SoundChannel = new SoundChannel();
		public var sndTransform:SoundTransform = new SoundTransform(0.5);
		public var soundOn:Boolean = true;
		public var sndMusic:SoundMusic = new SoundMusic();
		
		public var fbId:String = "";
		public var oFaceBookConnector:FaceBookConnector;
		
		public function GameContent():void
		{
			
			developementInit();
			developementStart();
		}
		
		public function musicStatusChange(stat:Boolean)
		{
			if (stat)
			{
				sndTransform = new SoundTransform(0.5);
				sndChannel.soundTransform = sndTransform;
				
			} else
			{
				sndTransform = new SoundTransform(0);
				sndChannel.soundTransform = sndTransform;
			}
		}
		
		public function fbConnect():void
		{
			// fb debug off
			
			oFaceBookConnector = FaceBookConnector.GetFaceBook(txt1);
			
			oFaceBookConnector.APKey = "272627332759019"
			oFaceBookConnector.APPID = "272627332759019"
			oFaceBookConnector.ReDirectURL = "https://apps.facebook.com/kokosymlokosy/";
			oFaceBookConnector.addEventListener("Connected",onFaceBookConnectHandler)
			oFaceBookConnector.Connect()
			function onFaceBookConnectHandler(e)
			{
				txt1.text = "Connected"
				txt2.text = oFaceBookConnector.UserInfo.UserID
				
				fbId = String(oFaceBookConnector.UserInfo.UserID).substr(3);
				txt3.text = fbId;
			
			}
			
				//checkUserExists();
		}
		
		private function developementInit():void 
		{
			fbConnect();
			countdown.visible = false;
			
			GlobalConfiguration.application = this;
			player = tratwa;
			
			AMFConnector.init();
			
			userInterface = UserInterface.getInstance(this);
			userInterface.activateInterface();
		
			lifeManager = LifeManager.getInstance();
			lifeManager.reset();
			
			resultsBridge = ResultsBridge.getInstance();
			
			gameTimer = GameTimer.getInstance(GlobalConfiguration.DEFAULT_GAME_TIME);
			
			globalInterface = new GlobalInterfaceFacade();
			MovieClip(this.parent).addChild(globalInterface);
			
			sndMusic = new SoundMusic();
			sndChannel = sndMusic.play();
			sndChannel.soundTransform = sndTransform;
			sndChannel.addEventListener(Event.SOUND_COMPLETE, musicRepeat);
			
			for (var i:int = 1 ; i <= GlobalConfiguration.COCO_HOLDERS_COUNT ; i++)
			{
				this["o" + i].activate();
			}
		}
		
		private function developementStart():void 
		{
			
			globalInterface.applyInterfaceState(GlobalInterfaceFacade.STATE_START);
			//globalInterface.applyInterfaceState(GlobalInterfaceFacade.STATE_GAMEPLAY);
			globalInterface.activate();
			
			//gameStart();
			
		}
		
		private function musicRepeat(e:Event):void 
		{
			sndMusic = new SoundMusic();
			sndChannel = sndMusic.play();
			sndChannel.soundTransform = sndTransform;
			sndChannel.addEventListener(Event.SOUND_COMPLETE, musicRepeat);
		}
		
		public function gameStart():void 
		{
			resultsBridge.score = 0;
			resultsBridge.enabled = true;
			
			ball.visible = false;
			countdownStart();
			
		}
		
		private function countdownStart():void 
		{
			countdown.visible = true;
			countdown.gotoAndPlay(1);
			TweenMax.delayedCall(3, addBall);
		}
		
		private function addBall():void
		{
			ball.visible = true;

			countdown.visible = false;
			ball.lifeCycleStart();
		}
		
		
		
		public function nextLife():void
		{
			lifes.lifeDown();
			ball.resetBallProps();
			//ball.visible = true;
			player.resetToDefaultPosition();
			countdownStart();
		}
		
		public function gameOver():void
		{
			trace("game over");
			resultsBridge.enabled = false;
			userInterface.deactivateInterface();
		}
		
//TODO no napisac to lol
		public function restartGame():void
		{
			// pozycja, aktualne sprite'y
			
			lifeManager.reset();
			lifes.reset();
			
			player.resetToDefaultPosition();
			for (var i:int = 1 ; i <= GlobalConfiguration.COCO_HOLDERS_COUNT ; i++)
			{
				this["o" + i].activate();
			}
			resultsBridge.score = 0;
			resultsBridge.enabled = true;
			globalInterface.resetInterface();
			
			userInterface.activateInterface();
			
		}
		
		
	}

}