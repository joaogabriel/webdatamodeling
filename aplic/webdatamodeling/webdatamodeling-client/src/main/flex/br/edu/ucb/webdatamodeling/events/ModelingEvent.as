package br.edu.ucb.webdatamodeling.events 
{
	import flash.events.Event;

	/**
	 * @author usuario
	 */
	public class ModelingEvent extends Event 
	{
		static public const SAVE:String = "save";
		static public const CLOSE:String = "save";
		static public const GENERATE_SQL:String = "genereteSQL";
		
		private var _tables:Array;
		
		public function get tables() : Array {return _tables;}
		
		public function ModelingEvent(type : String, tables:Array) 
		{
			_tables = tables;
			super(type);
		}
	}
}
