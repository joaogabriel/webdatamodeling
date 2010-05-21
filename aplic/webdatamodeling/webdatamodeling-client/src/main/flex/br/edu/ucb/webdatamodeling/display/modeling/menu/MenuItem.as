package br.edu.ucb.webdatamodeling.display.modeling.menu {
	import br.edu.ucb.webdatamodeling.display.modeling.events.MenuEvent;
	import flash.events.MouseEvent;

	import br.com.thalespessoa.utils.Library;

	import flash.display.Sprite;

	/**
	 * @author usuario
	 */
	internal class MenuItem extends Sprite 
	{
		private var _eventName : String;
		private var _param:*;

		public function MenuItem(linkageIcon:String, eventName:String, param:* = null) 
		{
			_param = param;
			_eventName = eventName;
			addChild(Library.get(linkageIcon));
			buttonMode = true;
			mouseChildren = false;
			addEventListener(MouseEvent.CLICK, clickHandler);
		}

		private function clickHandler(event : MouseEvent) : void 
		{
			event.stopImmediatePropagation();
			BaseMenu(parent).hide();
			dispatchEvent(new MenuEvent(_eventName, _param));
		}
	}
}
