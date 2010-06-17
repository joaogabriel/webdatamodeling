package br.edu.ucb.webdatamodeling.display.modeling.menu {
	import br.edu.ucb.webdatamodeling.display.modeling.RelationshipView;
	import br.edu.ucb.webdatamodeling.display.modeling.events.MenuEvent;

	/**
	 * @author usuario
	 */
	public class TableMenu extends BaseMenu 
	{
		public function TableMenu() 
		{
			//_items = new Vector.<MenuItem>(true, 3);
			_items = [];
			_items[0] = new MenuItem("icon_nn", MenuEvent.SELECT_CREATE_RELATIONSHIP, RelationshipView.TYPE_N_N);
			_items[1] = new MenuItem("icon_n1", MenuEvent.SELECT_CREATE_RELATIONSHIP, RelationshipView.TYPE_N_1);
			_items[2] = new MenuItem("icon_1n", MenuEvent.SELECT_CREATE_RELATIONSHIP, RelationshipView.TYPE_1_N);
			_items[3] = new MenuItem("icon_11", MenuEvent.SELECT_CREATE_RELATIONSHIP, RelationshipView.TYPE_1_1);
			_items[4] = new MenuItem("icon_close", MenuEvent.SELECT_DELETE);
			_items[5] = new MenuItem("icon_plus", MenuEvent.SELECT_PLUS);
			_items[6] = new MenuItem("icon_title", MenuEvent.SELECT_EDIT_TITLE);
			//_items[7] = new MenuItem("icon_clear", MenuEvent.SELECT_CLEAR);
			super();
		}
	}
}
