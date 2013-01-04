package com.boased.ui 
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	
	import com.boased.config.GlobalConfiguration;
	import com.boased.business.UserRank;
	import com.boased.events.AMFEvent;
	import com.boased.services.AMFConnector;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class PopupRanking extends MovieClip
	{
		
		
		public var evtDispatcher:EventDispatcher = new EventDispatcher();
		
		public function PopupRanking():void
		{
			
		}
		
		public function init():void
		{
			TweenPlugin.activate([ShortRotationPlugin, TransformAroundPointPlugin, TransformAroundCenterPlugin]);
			
			btnClose.buttonMode = true;
			TweenMax.to(this, 0, { transformAroundCenter: { scale:0.1 }} );
			alpha = 0;
			TweenMax.to(btnClose, 0, { scaleX:0.6, scaleY:0.6 } );
			visible = true;
		}
		
		public function activate():void
		{
			init();
			retrieveAMFData();
			
			btnClose.addEventListener(MouseEvent.CLICK, btnCloseClickHandler);
			btnClose.addEventListener(MouseEvent.MOUSE_OVER, btnCloseOverHandler);
			btnClose.addEventListener(MouseEvent.MOUSE_OUT, btnCloseOutHandler);
		}
		
		private function createRanking():void 
		{
			trace("asdasd" + UserRank.userName);
			nameUser.text = UserRank.userName;
			scoreUser.scoreLabel.txt.text = UserRank.userScore;
			userPositionTxt.text = UserRank.userPosition + ".";
			playcountUser.text = UserRank.userPlaycount;
			for (var i:int = 1 ; i <= 3 ; i++)
			{
				this["name" + i].text = UserRank.rankingNames[i-1];
				this["score" + i].scoreLabel.txt.text = UserRank.rankingScores[i-1];
				this["playcount" + i].text = UserRank.rankingPlaycount[i-1];
			}
		}
		
		public function retrieveAMFData():void
		{
			evtDispatcher.addEventListener(AMFEvent.RECIEVED, rankRecievedHandler);
			AMFConnector.getRank(this, GlobalConfiguration.application.fbId, "1");
		}
		
		private function rankRecievedHandler(e:AMFEvent):void 
		{
			var data:Object = AMFConnector.amfResponse;
			
			try
			{
				UserRank.userName = data[0].name;
				UserRank.userPosition = data[0].position;
				UserRank.userScore = data[0].score;
				UserRank.userPlaycount = data[0].game_count;
			} catch (e:Error)
			{
				trace("user not in rank error");
			}
			try
			{
				for (var i:int = 1; i <= 3 ; i++)
				{
					UserRank.rankingNames[i-1] = data[i].name;
					UserRank.rankingScores[i-1] = data[i].score;
					UserRank.rankingPlaycount[i-1] = data[i].game_count;
				}
			} catch (e:Error)
			{
				trace("high score not available");
			}
			evtDispatcher.removeEventListener(AMFEvent.RECIEVED, rankRecievedHandler);
			createRanking();
			TweenMax.to(this, 0.2, { alpha:1 } );
			TweenMax.to(this, 0.8, { transformAroundCenter:{ scale:1 } , ease:Elastic.easeOut} );
		}
		
		private function deactivate():void
		{
			btnClose.removeEventListener(MouseEvent.CLICK, btnCloseClickHandler);
			btnClose.removeEventListener(MouseEvent.MOUSE_OVER, btnCloseOverHandler);
			btnClose.removeEventListener(MouseEvent.MOUSE_OUT, btnCloseOutHandler);
			MovieClip(parent).hidePopupRanking();	
		}
		
//-------------------------------------------------


		private function btnCloseOutHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, 0.2, { scaleX:0.6, scaleY:0.6 } );
		}
		
		private function btnCloseOverHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, 0.1, { scaleX:0.8, scaleY:0.8 } );
		}
		
		private function btnCloseClickHandler(e:MouseEvent):void 
		{
			var _this:* = this;
			TweenMax.to(this, 0.7, { transformAroundCenter:{ scale:0.1 } , ease:Elastic.easeIn} );
			TweenMax.to(this, 0.4, { delay:0.2, alpha:0, onComplete:function() {
			_this.deactivate();
			}});
		}

		
	}

}