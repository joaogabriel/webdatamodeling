package br.edu.ucb.webdatamodeling.display.modeling.events 
{
	import br.edu.ucb.webdatamodeling.display.modeling.TableAttribute;
	import flash.events.Event;

	/**
	 * @author usuario
	 */
	public class TableEvent extends Event 
	{
		static public const ADD_PK:String = "addPK";
		
		private var _attribute:TableAttribute;
		
		public function get attribute() : TableAttribute {return _attribute;}
		
		public function TableEvent(type : String, attribute:TableAttribute) 
		{
			_attribute = attribute;
			super(type);
		}
	}
}
