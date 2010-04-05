package br.edu.ucb.webdatamodeling.display.modeling {
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author usuario
	 */
	public class RelationshipView extends Sprite 
	{
		private var _point1:TableView;
		private var _point2:TableView;
		
		public function get point1() : TableView {return _point1;}
		public function set point1(point1 : TableView) : void {_point1 = point1;}
		
		public function get point2() : TableView {return _point2;}
		public function set point2(point2 : TableView) : void {_point2 = point2;}
		
		public function RelationshipView( point1:TableView ) 
		{
			_point1 = point1;
			addEventListener(Event.ENTER_FRAME, drawingHandler);
			point1.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		private function draw( point1:Point, point2:Point ):void
		{
			graphics.clear();
			graphics.lineStyle(2);
			x = point1.x;
			y = point1.y;
			graphics.lineTo(point2.x - x, point2.y - y);
		}

		private function drawingHandler(event : Event) : void 
		{
			draw(new Point(_point1.x, _point1.y), new Point(parent.mouseX, parent.mouseY));
		}

		private function updateHandler(event : Event) : void 
		{
			draw(new Point(_point1.x, _point1.y), new Point(_point2.x, _point2.y));
		}

		private function mouseUpHandler(event : MouseEvent) : void 
		{
			point1.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			removeEventListener(Event.ENTER_FRAME, drawingHandler);
			if((event.target.parent is TableView) && (event.target.parent != point1))
			{
				point2 = event.target.parent;
				point1.addEventListener(TableView.DRAGGING, updateHandler);
				point2.addEventListener(TableView.DRAGGING, updateHandler);
			}
			else
				parent.removeChild(this);
		}
	}
}
