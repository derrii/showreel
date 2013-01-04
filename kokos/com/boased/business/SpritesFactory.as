package com.boased.business 
{
	import com.boased.sprites.ISprite;
	import com.boased.sprites.Leaf;
	import com.boased.sprites.Peanut;
	import com.boased.sprites.Rock;
	import com.boased.sprites.SuperPeanut;
	/**
	 * ...
	 * @author Adam Błażejewicz
	 */
	public class SpritesFactory
	{

		public static const LEAF:String = "leaf";
		public static const PEANUT:String = "peanut";
		public static const ROCK:String = "rock";
		public static const SUPER_PEANUT:String = "superpeanut";
		
		private static var factory:SpritesFactory;
		
		public static function getInstance():SpritesFactory
		{
			if (factory == null)
			{
				factory = new SpritesFactory();
			}
			
			return factory;
		}
		
		public function SpritesFactory() 
		{
			if (factory != null)
			{
				throw new Error("SpritesFactory is a singleton and should not be instantiated. Use getInstance() instead");
			}
		}
		
		public function getSprite(_type:String):ISprite
		{
			var sprite:ISprite;
			
			switch (_type)
			{
				case SpritesFactory.LEAF: sprite = new Leaf(); break;
				case SpritesFactory.PEANUT: sprite = new Peanut(); break;
				case SpritesFactory.ROCK: sprite = new Rock(); break;
				case SpritesFactory.SUPER_PEANUT: sprite = new SuperPeanut(); break;
			}
			
			return sprite;
		}
		
		
		
	}

}