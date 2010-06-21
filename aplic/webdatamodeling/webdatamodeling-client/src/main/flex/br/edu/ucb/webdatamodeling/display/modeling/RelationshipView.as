package br.edu.ucb.webdatamodeling.display.modeling {
	import br.edu.ucb.webdatamodeling.dto.CampoDTO;
	import br.com.thalespessoa.utils.Library;
	import br.edu.ucb.webdatamodeling.display.modeling.events.TableEvent;
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
		private var _card1:Sprite;
		private var _card2:Sprite;
		private var _type:String;
		private var _attributes:Array;
		private var _isAutoRelationship:Boolean;
		
		public function get point1() : TableView {return _point1;}
		public function set point1(point1 : TableView) : void {_point1 = point1;}
		
		public function get point2() : TableView {return _point2;}
		public function set point2(point2 : TableView) : void {_point2 = point2;}
		
		public function get type() : String {return _type;}
		
		public function RelationshipView( point1:TableView, type:String, point2:TableView = null) 
		{
			_type = type;
			_point1 = point1;
			_attributes = [];

			TweenMax.from(this, .3, {alpha:0});
			
			switch(type)
			{
				case TYPE_1_1: 
					_card1 = Library.get("icon_card1");
					_card2 = Library.get("icon_card1");
				break;
				case TYPE_1_N: 
					_card1 = Library.get("icon_card1");
					_card2 = Library.get("icon_cardN");
				break;
				case TYPE_N_1: 
					_card1 = Library.get("icon_cardN");
					_card2 = Library.get("icon_card1");
				break;
			}
			
			if(point2)
				completeRelationship(point2); 
			else
			{
				addEventListener(Event.ENTER_FRAME, drawingHandler);
				point1.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				point1.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				point1.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			}
		}

		private function rollOutHandler(event : MouseEvent) : void 
		{
			_isAutoRelationship = false;
		}

		private function rollOverHandler(event : MouseEvent) : void 
		{
			_isAutoRelationship = true;
		}

		public function kill():void
		{
			var len:uint;
			TweenMax.to(this, .1, {alpha:0, onComplete:onKill});
			point1.removeRelationship(this);
			point2.removeRelationship(this);
			
			point1.removeEventListener(TableEvent.ADD_PK, addPKHandler);
			point2.removeEventListener(TableEvent.ADD_PK, addPKHandler);
			
			len = _point2.pk.length;
			for(i=0; i < len; i++) _point2.pk[i].removeEventListener(TableAttribute.CHANGE_PK, changePKHandler);
			
			len = _point1.pk.length;
			for(i=0; i < len; i++) _point1.pk[i].removeEventListener(TableAttribute.CHANGE_PK, changePKHandler);
			
			len = _attributes.length;
			for(var i:uint = 0; i<len; i++)
			{
				TableAttribute(_attributes[i]).removeEventListener(Event.CLOSE, killAttributeHandler );
				if(TableAttribute(_attributes[i]).parent)
					TableAttribute(_attributes[i]).kill();
			}
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
			var i:uint;
			
			switch( _type )
			{
				case TYPE_1_1:
					point1.addEventListener(TableEvent.ADD_PK, addPKHandler);
					point2.addEventListener(TableEvent.ADD_PK, addPKHandler);
					_attributes = _attributes.concat(att = point1.fk);
					point2.addAttributes(att);
					_attributes = _attributes.concat(att = point2.fk);
					point1.addAttributes(att);
					for(i=0; i < _point2.pk.length; i++) _point2.pk[i].addEventListener(TableAttribute.CHANGE_PK, changePKHandler);
					for(i=0; i < _point1.pk.length; i++) _point1.pk[i].addEventListener(TableAttribute.CHANGE_PK, changePKHandler);
				break;
				case TYPE_1_N:
					point1.addEventListener(TableEvent.ADD_PK, addPKHandler);
					_attributes = _attributes.concat(att = point1.fk);
					point2.addAttributes(att);
					for(i=0; i < _point1.pk.length; i++) _point1.pk[i].addEventListener(TableAttribute.CHANGE_PK, changePKHandler);
				break;
				case TYPE_N_1:
					point2.addEventListener(TableEvent.ADD_PK, addPKHandler);
					_attributes = _attributes.concat(att = point2.fk);
					point1.addAttributes(att);
					for(i=0; i < _point2.pk.length; i++) _point2.pk[i].addEventListener(TableAttribute.CHANGE_PK, changePKHandler);
				break;
			}
			addChild(_card1);
			addChild(_card2);
			
			var len:uint = _attributes.length;
			
			for( var i:uint = 0; i < len; i++ ) 
				_attributes[i].addEventListener(Event.CLOSE, killAttributeHandler );
		}

		private function killAttributeHandler(event : Event) : void 
		{
			kill();
		}

		private function addPKHandler(event : TableEvent) : void 
		{
			var fk:TableAttribute = event.attribute.createFK(TableView(event.target));
			var point:TableView = event.target == point1 ? point2 : point1;

			point.addAttribute(fk);
			
			_attributes.push( fk );
			fk.addEventListener(Event.CLOSE, killAttributeHandler );
			
			event.attribute.addEventListener(TableAttribute.CHANGE_PK, changePKHandler);
		}

		private function changePKHandler(event : Event) : void 
		{
			event.target.removeEventListener(TableAttribute.CHANGE_PK, changePKHandler);

			TableAttribute(event.target).fk.kill();
			_attributes.splice(_attributes.indexOf(TableAttribute(event.target).fk), 1);
			
			TableAttribute(event.target).fk.addEventListener(Event.CLOSE, killAttributeHandler );
		}

		public function update():void
		{
			draw(new Point(_point1.centerX, _point1.centerY), new Point(_point2.centerX, _point2.centerY));
		}
		
		private function onKill():void
		{
			if(parent)
				parent.removeChild(this);
		}

		private function draw( point1:Point, point2:Point ):void
		{
			graphics.clear();
			graphics.lineStyle(2, 0x666666);
			x = point1.x;
			y = point1.y;
			/*
			var a:Number;
			//trace(a = Math.atan2(y, x) * 180 / Math.PI, Math.cos(a), Math.sin(a) );
			_card1.x = Math.cos(a) * 100; 
			_card1.y = Math.sin(a) * 100; 
			
			a = Math.atan2(y - point2.y, x - point2.x) * 180 / Math.PI, Math.cos(a), Math.sin(a);
			_card2.x = point2.x - x + Math.cos(a) * 100; 
			_card2.y = point2.y - y + Math.sin(a) * 100; 

			//graphics.lineTo(point2.x - x, 0);
*/
			var difX:Number;
			var difY:Number;
			
			if(_isAutoRelationship)
			{
				graphics.lineTo( 100, 0);
				graphics.lineTo( 100, -100);
				graphics.lineTo( 0, -100);
				graphics.lineTo( 0, 0);
			}
			else
			{
				difX = (point2.x - x)/2;
				difY = (point2.y - y)/2;
				graphics.lineTo(point2.x - x, point2.y - y);
				graphics.drawCircle(difX, difY, 2);
				
				if(type != RelationshipView.TYPE_N_N)
				{
					_card2.x = difX * 1.1;
					_card2.y = difY * 1.1;
					_card1.x = difX * .9;
					_card1.y = difY * .9;
				}
			}
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
			point1.removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			point1.removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			removeEventListener(Event.ENTER_FRAME, drawingHandler);
			//if((event.target.parent is TableView) && (event.target.parent != point1) && (type != TYPE_N_N))
			if((event.target.parent is TableView) && (type != TYPE_N_N))
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
