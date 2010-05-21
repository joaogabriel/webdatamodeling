package br.com.thalespessoa.utils 
{
	import flash.display.Shape;
	/**
	 * ...
	 * @author contato@thalespessoa.com.br
	 */
	public final class DisplayUtils
	{
		
		static public function drawRect( width:Number, height:Number, color:uint, prop:Object = null ):Shape
		{
			var rect:Shape = new Shape();
			rect.graphics.beginFill( color, 1 );
			rect.graphics.drawRect( 0, 0, width, height );
			rect.graphics.endFill();
			
			GenericUtils.setProperties( rect, prop );
			
			return rect;
		}
		
		static public function drawLineRect( width:Number, height:Number, color:uint, prop:Object = null ):Shape
		{
			var s:Shape = new Shape();
			s.graphics.lineStyle( 1, color );
			s.graphics.drawRect( 0, 0, width, height );
			
			GenericUtils.setProperties( s, prop );
			
			return s;
		}
		
		static public function drawCircle( radius:Number, color:uint, prop:Object = null ):Shape
		{
			var s:Shape = new Shape();
			s.graphics.beginFill( color );
			s.graphics.drawCircle(0, 0, radius);
			s.graphics.endFill();
			
			GenericUtils.setProperties( s, prop );
			
			return s;
		}
	}
}