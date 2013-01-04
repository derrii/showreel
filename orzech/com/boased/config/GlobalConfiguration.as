package com.boased.config 
{
	
	
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class GlobalConfiguration 
	{
		
		// MISC
		
		public static var application:GameContent;
		
		public static const STAGE_PADDING_LEFT:Number = 100;
		public static const STAGE_PADDING_RIGHT:Number = 730;
		
		
		public static const STAGE_GROUND_LEVEL:Number = 351;
		
		
		
		// GAME LOGIC
		
		public static const SCORE_PEANUT_VALUE:Number = 10;
		public static const DEFAULT_GAME_TIME:int = 90;
		public static const DEFAULT_SCORE:String = "0";
		public static const SUPER_PEANUT_CHANCE:Number = 0.1;
		public static const SUPER_PEANUT_DURATION = 8;
		
		// PLAYER CHARACTER
		
		public static const PLAYER_AUTO_MOVEMENT_STEP:Number = 8;
		public static const PLAYER_AUTO_MOVEMENT_DELTA:Number = 0.15;
		public static const PLAYER_AUTO_MOVEMENT_MIN_DELTA:Number = 0.15;
		public static const PLAYER_STUNNED_DURATION:Number = 2;
		
		// CLOUDS
		
		public static const CLOUDS_TWEEN_MARGIN:Number = 400;
		
		// BACKGROUND
		
		public static const BG1_TWEEN_MARGIN:Number = 55;
		public static const BG2_TWEEN_MARGIN:Number = 30;
		public static const BG3_TWEEN_MARGIN:Number = 10;
		
		// PEANUTS - LOGIC
		
		public static const PEANUTS_HOLDERS_COUNT:Number = 22;
		public static const PEANUTS_SEED_TIME:Number = 1.6;
		public static const PEANUTS_SEED_LIFETIME:Number = 2;
		
		// PEANUTS - ANIMATION
		
		
		public static const PEANUT_HANG_TIME:Number = 1.2;
		public static const PEANUT_LIFE_TIME:Number = 2;
		
		public static const PEANUT_ROTATION_MARGIN:Number = 30;		
		public static const PEANUT_FALL_TIME:Number = 1.7;
		public static const PEANUT_FALL_MARGIN:Number = 400;
		public static const PEANUT_ROTATION_VELOCITY:Number = 0.6;
		
		public static const PEANUT_BOUNCE_MARGIN:Number = 10;
		public static const PEANUT_BOUNCE_TIME:Number = 0.3;
		
		// LEAF - ANIMATION
		
		public static const LEAF_TOP_MARGIN:Number = 40;
		public static const LEAF_BOTTOM_MARGIN:Number = 250;
		
		public static const LEAF_ROTATION_MARGIN:Number = 30;
		public static const LEAF_FALL_TIME:Number = 2.8;
		public static const LEAF_FALL_MARGIN:Number = 380;
		public static const LEAF_ROTATION_VELOCITY:Number = 0.6;
		public static const LEAVES_SEED_TIME:Number = 1;
		
		// ROCK - ANIMATION
		
		public static const ROCK_SPIN :Number = 9;
		public static const ROCK_VELOCITY :Number = 12;
		public static const ROCK_GRAVITY :Number = 20;
		public static const ROCK_TOP_BOUNDARY: Number = 100;
		public static const ROCK_BOTTOM_BOUNDARY: Number = 250;
		public static const ROCK_SEED_TIME:Number = 9;
		
	}

}