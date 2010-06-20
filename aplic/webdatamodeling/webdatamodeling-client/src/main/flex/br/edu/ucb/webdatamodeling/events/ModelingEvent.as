package br.edu.ucb.webdatamodeling.events 
{
	import flash.events.Event;

	/**
	 * @author usuario
	 */
	public class ModelingEvent extends Event 
	{
		static public const SAVE:String = "save";
		static public const CLOSE:String = "close";
		static public const GENERATE_SQL:String = "genereteSQL";
		
		private var _tables:Array;
		private var _notes:Array;
		
		public function get tables() : Array {return _tables;}
		
		public function get notes() : Array {return _notes;}
		
		public function ModelingEvent(type : String, tables:Array = null, notes:Array = null) 
		{
			_tables = tables;
			_notes = notes;
			super(type);
		}
	}
}
