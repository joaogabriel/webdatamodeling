package br.com.thalespessoa.utils
{
	
	/**
	 * ...
	 * @author Thales Pessoa | contato@thalespessoa.com.br
	 */
	public class Glossary 
	{
		static private var _param:Object;
		
		static public function init( glossary:XML ):void
		{
			_param = { };
			
			for (var i:int = 0; i < glossary.param.length(); i++) 
				_param[glossary.param[i].@name] = glossary.param[i];
		}
		
		static public function get( name:String ):String
		{
			return _param[name];
		}	
	}	
}