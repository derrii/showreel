package com.boased.business 
{
	
	import com.boased.config.GlobalConfiguration;
	import com.boased.events.ScoreEvent;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class ResultsBridge implements IResultsBridge 
	{
		
		public static const INCREASE:String = "increase";
		public static const INCREASE_FULL:String = "increasefull";
		public static const INCREASE_SUPER:String = "increasesuper";
		public static const DECREASE:String = "decrease";
		public static const RESET:String = "reset";
		
		private var _score:Number;
		
		public var evtDispatcher:EventDispatcher = new EventDispatcher();
		
		public var enabled:Boolean;
		
		public static var resultsBridge:ResultsBridge;
		
		public static function getInstance():ResultsBridge
		{
			if (resultsBridge == null)
			{
				resultsBridge = new ResultsBridge();
				resultsBridge.updateScore(ResultsBridge.RESET);
			}
			return resultsBridge;
		}
		
		public function ResultsBridge() 
		{
			if (resultsBridge != null)
			{
				throw new Error("ResultsBridge is a singleton and should not be instantiated. Use getInstance() instead");
			}
		}
		
		public function get score():Number
		{
			return _score;
		}
		
		
		public function set score(_value:Number):void
		{
			_score = (_value > 0) ? _value : 0; 	
		}
		
		public function updateScore(_type:String):void
		{
			if (enabled)
			{
				
				switch (_type)
				{
					case ResultsBridge.INCREASE: score = score + GlobalConfiguration.SCORE_COCO_VALUE; break;
					case ResultsBridge.INCREASE_FULL: score = score + GlobalConfiguration.SCORE_COCOFULL_VALUE; break;
					case ResultsBridge.INCREASE_SUPER: score = score + GlobalConfiguration.SCORE_WAFELKI_VALUE; break;
					//case ResultsBridge.DECREASE: score = score - GlobalConfiguration.SCORE_PEANUT_VALUE; break;
					case ResultsBridge.RESET: score = 0; break;
				}
				
				// evt dispatch
				evtDispatcher.dispatchEvent(new ScoreEvent(ScoreEvent.CHANGE));
			}
		}
		
		
	}

}