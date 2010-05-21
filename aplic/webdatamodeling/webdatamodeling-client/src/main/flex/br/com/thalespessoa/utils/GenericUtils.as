package br.com.thalespessoa.utils 
{
	/**
	 * ...
	 * @author contato@thalespessoa.com.br
	 */
	public final class GenericUtils
	{
		
		static public function setProperties( object:Object, properties:Object ):void
		{
			for (var name:String in properties)
				object[name] = properties[name];
		}
	}
}