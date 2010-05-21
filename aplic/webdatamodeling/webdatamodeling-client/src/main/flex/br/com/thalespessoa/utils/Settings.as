package br.com.thalespessoa.utils 
{
	
	/**
	 * ...
	 * @author Thales Pessoa | contato@thalespessoa.com.br
	 */
	public final class Settings 
	{
		static private var _param:Object;
		
		static public function init( settings:XML ):void
		{
			_param = { };
			
			for (var i:int = 0; i < settings.param.length(); i++) 
				_param[settings.param[i].@name] = settings.param[i].@value;
		}
		
		static public function get( name:String ):String
		{
			return _param[name];
		}		
	}	
}