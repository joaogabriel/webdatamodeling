package br.edu.ucb.webdatamodeling.display.modeling.menu {
	import br.edu.ucb.webdatamodeling.display.modeling.events.MenuEvent;

	/**
	 * @author usuario
	 */
	public class RelationshipMenu extends BaseMenu 
	{
		public function RelationshipMenu() 
		{
			_items = [];
			_items[0] = new MenuItem("icon_close", MenuEvent.SELECT_DELETE);
			super();
		}
	}
}
