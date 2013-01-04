package com.boased.utils 
{
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	 
	
	public class TimeFormat 
	{
		
		public static function intToString(_time:int):String
		{
			var timeString:String;
			
			var mins:int = (_time - (_time % 60) )/ 60;
			var secs:int = _time % 60;
			var tm:String;
			var ts:String;
			
			if (mins.toString().length == 1) { tm = "0" + mins } else { tm = mins.toString() }
			if (secs.toString().length == 1) {ts = "0"+secs} else {ts = secs.toString()}
			
			timeString = tm + ":" + ts;
			
			return timeString;
		}
	}

}