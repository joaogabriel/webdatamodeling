package br.edu.ucb.webdatamodeling.display.modeling {
	import gs.TweenMax;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author usuario
	 */
	public class RelationshipView extends Sprite 
	{
		static public const TYPE_1_1:String = "11";
		static public const TYPE_1_N:String = "1n";
		static public const TYPE_N_1:String = "n1";
		static public const TYPE_N_N:String = "nn";
		
		private var _point1:TableView;
		private var _point2:TableView;
		private var _type:String;
		private var _attributes:Array;
		
		public function get point1() : TableView {return _point1;}
		public function set point1(point1 : TableView) : void {_point1 = point1;}
		
		public function get point2() : TableView {return _point2;}
		public function set point2(point2 : TableView) : void {_point2 = point2;}
		
		public function get type() : String {return _type;}
		
		
		public function RelationshipView( point1:TableView, type:String, point2:TableView = null ) 
		{
			_type = type;
			_point1 = point1;
			_attributes = [];

			TweenMax.from(this, .3, {alpha:0});
			
			if(point2)
				completeRelationship(point2);
			else
			{
				addEventListener(Event.ENTER_FRAME, drawingHandler);
				point1.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			}
		}
		
		public function kill():void
		{
			TweenMax.to(this, .1, {alpha:0, onComplete:onKill});
			point1.removeRelationship(this);
			point2.removeRelationship(this);
			
			for(var i:uint = 0; i<_attributes.length; i++)
				TableAttribute(_attributes[i]).kill();
		}

		public function completeRelationship(point:TableView):void
		{
			point2 = point;
			point1.addEventListener(TableView.DRAGGING, updateHandler);
			point2.addEventListener(TableView.DRAGGING, updateHandler);
			point1.addRelationship(this);
			point2.addRelationship(this);
			
			update();
			
			var att:Array;
			
			switch( _type )
			{
				case TYPE_1_1:
					_attributes = _attributes.concat(att = point1.fk);
					point2.addAttributes(att);
					_attributes = _attributes.concat(att = point2.fk);
					point1.addAttributes(att);
				break;
				case TYPE_1_N:
					_attributes = _attributes.concat(att = point1.fk);
					point2.addAttributes(att);
				break;
				case TYPE_N_1:
					_attributes = _attributes.concat(att = point2.fk);
					point1.addAttributes(att);
				break;
			}
		}
		
		public function update():void
		{
			draw(new Point(_point1.centerX, _point1.centerY), new Point(_point2.centerX, _point2.centerY));
		}
		
		private function onKill():void
		{
			parent.removeChild(this);
		}

		private function draw( point1:Point, point2:Point ):void
		{
			graphics.clear();
			graphics.lineStyle(2, 0x666666);
			x = point1.x;
			y = point1.y;
			graphics.lineTo(point2.x - x, point2.y - y);
		}

		private function drawingHandler(event : Event) : void 
		{
			draw(new Point(_point1.centerX, _point1.centerY), new Point(parent.mouseX, parent.mouseY));
		}

		private function updateHandler(event : Event) : void 
		{
			update();
		}
		
		private function mouseDownHandler(event : MouseEvent) : void 
		{
			//event.stopImmediatePropagation();
			point1.stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			removeEventListener(Event.ENTER_FRAME, drawingHandler);
			if((event.target.parent is TableView) && (event.target.parent != point1) && (type != TYPE_N_N))
				completeRelationship(event.target.parent);
			else if((event.target.parent is TableView) && (event.target.parent != point1) && (type == TYPE_N_N))
			{
				point2 = event.target.parent;
				dispatchEvent(new Event(TYPE_N_N));
				parent.removeChild(this);
			}
			else
				parent.removeChild(this);
		}
	}
}
