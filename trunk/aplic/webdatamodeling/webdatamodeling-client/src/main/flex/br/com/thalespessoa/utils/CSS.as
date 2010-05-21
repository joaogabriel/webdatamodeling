package br.com.thalespessoa.utils
{
	import flash.text.StyleSheet;
	/**
	 * ...
	 * @author contato@thalespessoa.com.br
	 */
	public final class CSS
	{
		static private var _style:StyleSheet = new StyleSheet();
		
		static public function get style():StyleSheet { return _style; }
		
		static public function load( css:String ):void
		{
			_style.parseCSS( css );
			
		}
		
		static public function getStyle( styleName:String ):Object
		{
			return _style.getStyle( styleName );
		}
	}
}