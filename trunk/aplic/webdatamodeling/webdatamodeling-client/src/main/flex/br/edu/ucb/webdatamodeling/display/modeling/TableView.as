package br.edu.ucb.webdatamodeling.display.modeling {
	import gs.easing.Cubic;
	import gs.TweenMax;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import gs.*; 
	import gs.easing.*;

	/**
	 * @author usuario
	 */
	public class TableView extends Sprite 
	{
		static public const DRAGGING:String = "dragging";
		static public const START_RELATIONSHIP:String = "startRelationship";

		public function TableView() 
		{
			addEventListener(MouseEvent.CLICK, clickHandler);
			//addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			show();
			create();
		}

		public function show():void
		{
			TweenMax.from(this, .2, {scaleX:.6, scaleY:.6, alpha:0, ease:Cubic.easeOut});
		}
		
		public function hide():void
		{
			
		}
		
		private function create():void
		{
			var base:Sprite = new Sprite();
			base.graphics.beginFill(0xFFCC99);
			base.graphics.drawRect(-50, -50, 100, 100);
			base.graphics.endFill();
			addChild( base );
			base.addEventListener(MouseEvent.MOUSE_DOWN, baseMouseDownHandler);
			
			var title:Sprite = new Sprite();
			title.graphics.beginFill(0xFF9965);
			title.graphics.drawRect(-50, -50, 100, 50);
			title.graphics.endFill();
			addChild( title );
			title.addEventListener(MouseEvent.MOUSE_DOWN, titleMouseDownHandler);
		}

		private function baseMouseDownHandler(event : MouseEvent) : void 
		{
			dispatchEvent(new Event(START_RELATIONSHIP));
		}

		private function clickHandler(event : MouseEvent) : void 
		{
			event.stopImmediatePropagation();
		}

		private function draggingHandler(event : Event) : void 
		{
			dispatchEvent(new Event(DRAGGING));
		}

		private function titleMouseDownHandler(event : MouseEvent) : void 
		{
			parent.addChild(this);
			TweenMax.to(this, .3, {scaleX:1.1, scaleY:1.1, dropShadowFilter:{color:0x000000, alpha:.8, blurX:12, blurY:12, distance:10}});
			startDrag();
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			addEventListener(Event.ENTER_FRAME, draggingHandler);
		}

		private function mouseUpHandler(event : MouseEvent) : void 
		{
			TweenMax.to(this, .3, {scaleX:1, scaleY:1,dropShadowFilter:{color:null, alpha:0, blurX:0, blurY:0, distance:0}, ease:Bounce.easeOut});
			stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			removeEventListener(Event.ENTER_FRAME, draggingHandler);
		}
	}
}
