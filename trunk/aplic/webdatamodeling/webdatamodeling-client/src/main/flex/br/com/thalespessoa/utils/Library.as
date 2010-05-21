package br.com.thalespessoa.utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	/**
	 * ...
	 * @author contato@thalespessoa.com.br
	 */
	public final class Library
	{
		
		static public function get( item:String, prop:Object = null ) :Sprite
		{
			var Item:Class = ApplicationDomain.currentDomain.getDefinition(item) as Class;
			var obj:Sprite = new Item() as Sprite;
			GenericUtils.setProperties( obj, prop );
			
			return obj;		
		}
		
		static public function getAndAdd( item:String, container:DisplayObjectContainer, prop:Object = null ):Sprite
		{
			return container.addChild( get( item, prop ) ) as Sprite;
		}
	}
}