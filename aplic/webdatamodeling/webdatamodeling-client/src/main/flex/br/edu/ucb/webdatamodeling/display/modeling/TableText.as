package br.edu.ucb.webdatamodeling.display.modeling {
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import mx.managers.FocusManager;
	import flash.utils.setTimeout;
	import flash.events.FocusEvent;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	import br.com.thalespessoa.utils.GenericUtils;

	import flash.text.TextField;

	import br.com.thalespessoa.utils.TextFactory;
	import flash.display.Sprite;

	/**
	 * @author usuario
	 */
	public class TableText extends Sprite 
	{
		static public const TYPE_TITLE:String = "title";
		static public const TYPE_ATTRIBUTE:String = "attribute";
		static public const EDIT_FINISHED : String = "editFinished";

		private var _field:TextField;
		
		public function get text():String { return _field.text; };
		
		public function TableText( type:String, name:String, editNow:Boolean = true ) 
		{
			mouseEnabled = false;
			mouseChildren = false;
			if(type == TYPE_TITLE)
				createTitle(name);
			else if(type == TYPE_ATTRIBUTE)
				createAttribute(name);
			
			if(editNow)
				addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		public function edit() : void 
		{
			mouseChildren = true;
			mouseEnabled = true;
			_field.selectable = true;
			_field.type = TextFieldType.INPUT;
			stage.focus = _field;
			_field.setSelection(0, 999);
			addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}

		private function createField(prop:Object):void
		{
			_field =  new TextField();
			addChild( _field );
			
			_field.embedFonts = true;
			//_field.defaultTextFormat = format;
			//_field.type = TextFieldType.INPUT;
			_field.selectable = false;
			GenericUtils.setProperties( _field, prop );
			
			_field.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
			_field.addEventListener(Event.CHANGE, changeHandler);
		}
		
		private function disable():void
		{
			mouseChildren = false;
			_field.selectable = false;
			mouseEnabled = false;
			removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			dispatchEvent(new Event(EDIT_FINISHED));
		}

		private function createAttribute(name:String) : void 
		{
			var format:TextFormat = new TextFormat();
			format.font = "Arial_10pt_st";
			format.size = 10;
			format.color = 0x333333;
			createField({height:15, y:2, x:2, autoSize:TextFieldAutoSize.LEFT});
			_field.defaultTextFormat = format;
			_field.text = name;
		}

		private function createTitle(name:String) : void 
		{
			var format:TextFormat = new TextFormat();
			format.font = "Interstate-BoldCondensed";
			format.size = 15;
			format.color = 0x333333;
			createField({height:15, y:2, x:2, autoSize:TextFieldAutoSize.LEFT});
			_field.defaultTextFormat = format;
			_field.text = name;
		}

		private function focusOutHandler(event : FocusEvent) : void 
		{
			disable();
		}
		
		private function keyDownHandler(event : KeyboardEvent) : void 
		{
			if(event.keyCode == Keyboard.ENTER)
				disable();
		}

		private function changeHandler(event : Event) : void 
		{
			dispatchEvent(new Event(Event.RESIZE));
		}

		private function addedToStageHandler(event : Event) : void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			edit();
		}
	}
}
