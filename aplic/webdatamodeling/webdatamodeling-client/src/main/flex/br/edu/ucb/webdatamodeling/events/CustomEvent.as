package br.edu.ucb.webdatamodeling.events
{
	import flash.events.Event;

	public class CustomEvent extends Event
	{
		private var _data:*;
		
		public function get data():*
		{
			return _data;
		}
		
		public function CustomEvent(type:String, data:*)
		{
			_data = data;
			super(type);
		}
		
	}
}