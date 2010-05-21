package br.edu.ucb.webdatamodeling.display.modeling.events 
{
	import flash.events.Event;

	/**
	 * @author usuario
	 */
	public class MenuEvent extends Event 
	{
		static public const SELECT_CREATE_TABLE:String = "selectCreateTable";
		static public const SELECT_GENERETE_CODE:String = "selectGenerateCode";
		static public const SELECT_CREATE_RELATIONSHIP:String = "selectCreateRelationship";
		static public const SELECT_SAVE : String = "selectSave";
		static public const SELECT_DELETE : String = "selectDelete";
		public static const SELECT_EDIT_TITLE : String = "editTitle";
		public static const SELECT_PLUS : String = "selectPlus";

		private var _data:*;
		
		public function get data() : * {return _data;}
		public function set data(data : *) : void {_data = data;}
		
		public function MenuEvent(type : String, data:*, bubbles:Boolean = true) 
		{
			_data = data;
			super(type, bubbles);
		}
	}
}
