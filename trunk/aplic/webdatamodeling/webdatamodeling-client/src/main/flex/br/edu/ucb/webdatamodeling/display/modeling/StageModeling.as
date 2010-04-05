package br.edu.ucb.webdatamodeling.display.modeling {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;

	/**
	 * @author usuario
	 */
	public class StageModeling extends Sprite 
	{
		private var _bg:Shape;
		
		public function StageModeling() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			_bg = new Shape();
			_bg.graphics.lineStyle(1, 0xCCCCCC);
			for(var i:uint = 0; i < 300; i++)
			{
				_bg.graphics.moveTo(i * 10, 0);
				_bg.graphics.lineTo(i * 10, 1000);
			}
			for(i = 0; i < 1000; i++)
			{
				_bg.graphics.moveTo(0, i * 10);
				_bg.graphics.lineTo(2000, i * 10);
			}
			addChild( _bg );
		}

		private function createTable() : void 
		{
			var table:TableView = new TableView();
			table.x = mouseX;
			table.y = mouseY;
			table.addEventListener(TableView.START_RELATIONSHIP, startRelationshipHandler);
			addChild(table);
		}

		private function startRelationshipHandler(event : Event) : void 
		{
			addChildAt(new RelationshipView(TableView( event.target )), 1);
		}

		private function addedToStageHandler(event : Event) : void 
		{
			stage.addEventListener(MouseEvent.CLICK, clickStageHandler);
		}

		private function clickStageHandler(event : MouseEvent) : void 
		{
			createTable();
		}
	}
}
