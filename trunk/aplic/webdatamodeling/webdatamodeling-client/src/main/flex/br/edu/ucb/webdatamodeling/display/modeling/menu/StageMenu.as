package br.edu.ucb.webdatamodeling.display.modeling.menu {
	import br.edu.ucb.webdatamodeling.display.modeling.events.MenuEvent;
	import br.com.thalespessoa.utils.DisplayUtils;

	/**
	 * @author usuario
	 */
	public class StageMenu extends BaseMenu 
	{
		public function StageMenu() 
		{
			//_items = new Vector.<MenuItem>(true, 4);
			_items = [];
			_items[0] = new MenuItem("icon_code", MenuEvent.SELECT_GENERETE_NOTE);
			_items[1] = new MenuItem("icon_table", MenuEvent.SELECT_CREATE_TABLE);
			_items[2] = new MenuItem("icon_close", MenuEvent.SELECT_DELETE);
			_items[3] = new MenuItem("icon_save", MenuEvent.SELECT_SAVE);
			//_items[4] = new MenuItem("icon_clear", MenuEvent.SELECT_CLEAR);
			/*_items[4] = new MenuItem("icon_code", MenuEvent.SELECT_GENERETE_CODE);
			_items[5] = new MenuItem("icon_table", MenuEvent.SELECT_CREATE_TABLE);
			_items[6] = new MenuItem("icon_close", MenuEvent.SELECT_DELETE);
			_items[7] = new MenuItem("icon_save", MenuEvent.SELECT_SAVE);*/
			super();
		}
	}
}