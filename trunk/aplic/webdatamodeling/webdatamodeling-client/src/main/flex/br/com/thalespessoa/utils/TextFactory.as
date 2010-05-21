package br.com.thalespessoa.utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author contato@thalespessoa.com.br
	 */
	public final class TextFactory
	{
		
		static public function createCSSField( prop:Object = null, ref:TextField = null ):TextField
		{
			var field:TextField = ref || new TextField();
			field.styleSheet = CSS.style;
			field.embedFonts = true;
			//field.antiAliasType = AntiAliasType.ADVANCED;
			field.mouseWheelEnabled = false;
			//field.condenseWhite  = true;
			GenericUtils.setProperties( field, prop );
			
			return field;
		}
		
		static public function createText( prop:Object, format:TextFormat, ref:TextField = null ):TextField
		{
			var field:TextField = ref || new TextField();
			
			field.embedFonts = true;
			field.defaultTextFormat = format;
			GenericUtils.setProperties( field, prop );
			
			return field;
		}
	}
}