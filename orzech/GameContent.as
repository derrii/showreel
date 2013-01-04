package  
{
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	
	
	// CORE LIBS
	 
	
	import com.boased.business.ResultsBridge;
	import com.boased.sprites.ISprite;
	import flash.events.*;
	import flash.display.*;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	
	// GAME SPECIFIC LIBS
	
	import com.boased.background.BackgroundPan;
	import com.boased.business.SpritesFactory;
	import com.boased.business.GameTimer;
	
	import com.boased.ui.UserInterface;
	
	import com.boased.config.GlobalConfiguration;
	import com.boased.utils.TimeFormat;
	
	import com.boased.sprites.IPlayer;

	import com.boased.events.ScoreEvent;
	import com.boased.events.TimeEvent;
	
	import com.boased.ui.GlobalInterfaceFacade;
	
	import com.boased.services.AMFConnector;
	import com.boased.events.AMFEvent;
	import com.boased.business.UserRank;
	
	import flash.media.*;
	
	public class GameContent extends MovieClip
	{
		
		public var spritesFactory:SpritesFactory;
		public var userInterface:UserInterface;
		public var resultsBridge:ResultsBridge;
		public var gameTimer:GameTimer;
		
		public var plan1:BackgroundPan;
		public var plan2:BackgroundPan;
		public var plan3:BackgroundPan;
		
		public var player:IPlayer;
		
		public var peanutHoldersLoc:Array = new Array();
		public var peanutHolders:Array = new Array();
		
		public var globalInterface:GlobalInterfaceFacade;
		
		public var spritesAdded:Array = new Array();
		
		
		public var oFaceBookConnector:FaceBookConnector;
		public var fbId:String = "";
		
		public var sndChannel:SoundChannel = new SoundChannel();
		public var sndTransform:SoundTransform = new SoundTransform(1);
		public var soundOn:Boolean = true;
		
		public function GameContent():void
		{
			fbConnect();
			init();
			developementStartup();
			
		}
		
		public function musicStatusChange(stat:Boolean)
		{
			if (stat)
			{
				sndTransform = new SoundTransform(1);
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
			//oFaceBookConnector.APKey = "518324a04fe7886ce1356383e3e39201"
			oFaceBookConnector.APKey = "270138533003999"
			oFaceBookConnector.APPID = "270138533003999"
			//oFaceBookConnector.ReDirectURL ="http://flptv.eura7.pl/public/horalky/redirect/"
			oFaceBookConnector.ReDirectURL = "http://apps.facebook.com/horalkyone/";
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
		
		private function init():void 
		{
			GlobalConfiguration.application = this;
			player = futrzak;
			
			for (var i = 1 ; i <= GlobalConfiguration.PEANUTS_HOLDERS_COUNT ; i++)
			{
				peanutHoldersLoc.push(this["peanutHolder" + i]);
			}
		}
		
		private function developementStartup():void 
		{
			
			
			plan1.movementMargin = GlobalConfiguration.BG1_TWEEN_MARGIN;
			plan2.movementMargin = GlobalConfiguration.BG2_TWEEN_MARGIN;
			plan3.movementMargin = GlobalConfiguration.BG3_TWEEN_MARGIN;
			
			for (var i = 1; i <= 3 ; i++)
			{
				this["plan" + i].start();
			}
			
			//--------------
			
			AMFConnector.init();
			
			//retrieveAMFData();
			
			
			userInterface = UserInterface.getInstance(this);
			userInterface.activateInterface();
			
			spritesFactory = SpritesFactory.getInstance();
			
			resultsBridge = ResultsBridge.getInstance();
			
			gameTimer = GameTimer.getInstance(GlobalConfiguration.DEFAULT_GAME_TIME);
			
			globalInterface = new GlobalInterfaceFacade();
			MovieClip(this.parent).addChild(globalInterface);
			
			globalInterface.applyInterfaceState(GlobalInterfaceFacade.STATE_START);
			globalInterface.activate();
			
			/*globalInterface.applyInterfaceState(GlobalInterfaceFacade.STATE_GAMEPLAY);
			globalInterface.activate();
			
			// game start
			
			gameTimer.activate();
			
			leavesLifeStart();
			peanutsLifeStart();
			rocksLifeStart();*/
			
		}
		
		public function gameStart():void
		{
			gameTimer.activate();
			
			//if (soundOn)
			//{
				var snd:SoundMusic = new SoundMusic();
				sndChannel = snd.play();
				sndChannel.soundTransform = sndTransform;
			//}
			resultsBridge.score = 0;
			resultsBridge.enabled = true;
			leavesLifeStart();
			peanutsLifeStart();
			rocksLifeStart();
		}
		
		public function gameOver():void
		{
			//
			resultsBridge.enabled = false;
			TweenMax.killDelayedCallsTo(leavesLifeStart);
			TweenMax.killDelayedCallsTo(peanutsLifeStart);
			TweenMax.killDelayedCallsTo(rocksLifeStart);
			
			userInterface.deactivateInterface();
		}
		
		public function restartGame():void
		{
			// pozycja, aktualne sprite'y
			
			clearDisplayList();
			player.resetToDefaultPosition();
			resultsBridge.score = 0;
			resultsBridge.enabled = true;
			globalInterface.resetInterface();
			gameTimer.reset();
			userInterface.activateInterface();
			
			//if (soundOn)
			//{
				var snd:SoundMusic = new SoundMusic();
				sndChannel = snd.play();
				sndChannel.soundTransform = sndTransform;
			//}
			
		}
		
		private function clearDisplayList():void 
		{
			for (var i = 0 ; i <= spritesAdded.length - 1 ; i++)
			{
				for (var j = 0 ; j <= this.numChildren - 1 ; j++)
				{
					if (spritesAdded[i] == this.getChildAt(j))
					{
						this.removeChild(spritesAdded[i]);
					}
				}
			}
			spritesAdded = new Array();
		}
		
		
		
		private function peanutsLifeStart():void 
		{
			var spr:MovieClip 
			var superPeanutRnd:Number = Math.random();
			
			if (superPeanutRnd < GlobalConfiguration.SUPER_PEANUT_CHANCE)
			{
				spr = spritesFactory.getSprite(SpritesFactory.SUPER_PEANUT) as MovieClip;
			} else
			{
				spr = spritesFactory.getSprite(SpritesFactory.PEANUT) as MovieClip;
			}
		
			spr.randomizeLocation();
			spritesAdded.push(spr);
			addChildAt(spr, 8);
			this.setChildIndex(DisplayObject(player), this.numChildren-1);
			spr.lifeCycleStart();
			var speedFactor:Number;
			if (gameTimer.timeRemaining > 20)
			{
				speedFactor = 0.2+(gameTimer.timeRemaining - 20) / GlobalConfiguration.DEFAULT_GAME_TIME;
			} else
			{
				speedFactor = 0.2;
			}
			var speed:Number=0.4 + GlobalConfiguration.PEANUTS_SEED_TIME * speedFactor;
			
			//trace("ftr:" + GlobalConfiguration.PEANUTS_SEED_TIME * (gameTimer.timeRemaining / GlobalConfiguration.DEFAULT_GAME_TIME));
			//trace("spd:"+speed);
			TweenMax.delayedCall(speed, peanutsLifeStart);
//			TweenMax.delayedCall(GlobalConfiguration.PEANUTS_SEED_TIME-((GlobalConfiguration.PEANUTS_SEED_TIME/2)*((1/(gameTimer.timeRemaining+1)))), peanutsLifeStart);
		}
		
		private function leavesLifeStart():void
		{
			var spr:MovieClip = spritesFactory.getSprite(SpritesFactory.LEAF) as MovieClip;
			spr.randomizeLocation();
			spritesAdded.push(spr);
			addChild(spr);
			spr.lifeCycleStart();
			TweenMax.delayedCall(GlobalConfiguration.LEAVES_SEED_TIME * Math.random(), leavesLifeStart);
		}
		
		private function rocksLifeStart():void 
		{
			var spr:MovieClip = spritesFactory.getSprite(SpritesFactory.ROCK) as MovieClip;
			spr.randomizeLocation();
			spritesAdded.push(spr);
			addChild(spr);
			spr.lifeCycleStart();
			
			TweenMax.delayedCall(GlobalConfiguration.ROCK_SEED_TIME * Math.random(), rocksLifeStart);
		}

		public function swapChildWithPlayer(_child:DisplayObject):void
		{
			//this.setChildIndex(DisplayObject(player), this.numChildren-1);
			//this.swapChildren(DisplayObject(player), _child);
			//trace("swap "+this.getChildIndex(DisplayObject(player))+"  "+this.getChildIndex(_child));
		}
		
	}
}