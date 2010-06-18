package br.edu.ucb.webdatamodeling.display.modeling {
	import br.com.thalespessoa.utils.Library;

	import gs.TweenMax;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import br.com.thalespessoa.utils.DisplayUtils;
	import flash.text.TextField;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * @author usuario
	 */
	public class NoteView extends Sprite 
	{
		private var _bg:Sprite;
		private var _text:TableText;
		private var _close:DisplayObject;
		private var _title:TableText;
		private var _closeButton:Sprite;
		
		public function NoteView( text:String = null ) 
		{
			create();
		}

		private function create() : void 
		{
			_bg = new Sprite();
			_bg.graphics.beginFill(0xC9B035);
			_bg.graphics.drawRect(0, 0, 200, 40);
			_bg.graphics.endFill();
			_bg.alpha = .8;
			addChild(_bg);
			addChild(_title = new TableText(TableText.TYPE_TITLE, "Note", false));
			_text = new TableText(TableText.TYPE_OTHER, "note", true);
			_text.width = _bg.width;
			_text.y = 20;
			addChild(_text);
			
			_title.buttonMode = true;
			_title.mouseEnabled = true;
			
			_text.addEventListener(MouseEvent.CLICK, clickTextHandler);
			//_title.addEventListener(MouseEvent.CLICK, clickTextHandler);
			_text.addEventListener(TableText.EDIT_FINISHED, textEditFinishedHandler);
			_title.addEventListener(TableText.EDIT_FINISHED, textEditFinishedHandler);
			_text.addEventListener(Event.RESIZE, textResizeHandler);
			_title.addEventListener(Event.RESIZE, titleResizeHandler);
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
			TweenMax.from(_bg, .3, {scaleY:0});
			TweenMax.from(_title, .3, {alpha:0, delay:.2});
			TweenMax.from(_text, .3, {alpha:0, delay:.3});
			
			
			_closeButton = Library.get("icon_close_little", { y:10, x:190, buttonMode:true });
			_closeButton.addEventListener( MouseEvent.CLICK, clickCloseHandler );
			addChild(_closeButton);
		}

		private function clickCloseHandler(event : MouseEvent) : void 
		{
			TweenMax.to(_bg, .3, {scaleY:0, delay:.4, onComplete:onKill});
			TweenMax.to(_title, .3, {alpha:0, delay:.2});
			TweenMax.to(_text, .3, {alpha:0});
			TweenMax.to(_closeButton, .3, {alpha:0});
		}
		
		private function onKill():void
		{
			parent.removeChild(this);
		}

		private function titleResizeHandler(event : Event) : void 
		{
			_bg.width = Math.max(200, _title.width);
			_text.width = _bg.width;
		}

		private function textResizeHandler(event : Event) : void 
		{
			_bg.height = _text.y + _text.height + 3;
		}

		private function mouseDownHandler(event : MouseEvent) : void 
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			startDrag();
			parent.addChild(this);
		}

		private function mouseUpHandler(event : MouseEvent) : void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stopDrag();
		}

		private function clickHandler(event : MouseEvent) : void 
		{
			event.stopImmediatePropagation();
		}

		private function clickTextHandler(event : MouseEvent) : void 
		{
			event.currentTarget.edit();
		}

		private function textEditFinishedHandler(event : Event) : void 
		{
			//buttonMode = true;
			event.target.buttonMode = true;
			event.target.mouseEnabled = true;
		}
	}
}
