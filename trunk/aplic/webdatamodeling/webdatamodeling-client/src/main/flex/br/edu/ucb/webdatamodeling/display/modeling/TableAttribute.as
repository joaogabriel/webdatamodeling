package br.edu.ucb.webdatamodeling.display.modeling {
	import br.edu.ucb.webdatamodeling.display.modeling.ui.Combo;
	import br.edu.ucb.webdatamodeling.dto.CampoDTO;
	import flash.utils.setTimeout;
	import gs.TweenMax;
	import br.com.thalespessoa.utils.Library;

	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author usuario
	 */
	public class TableAttribute extends Sprite 
	{
		static public const KILL : String = "kill";
		
		static private var _i:uint = 0;

		private var _text:TableText;
		private var _closeButton:Sprite;
		private var _isPK:Boolean;
		private var _isFK:Boolean;
		private var _fkTable:TableView;
		private var _dto : CampoDTO;
		private var _comboType:Combo;

		override public function get width():Number{return super.width - 15;}
		
		public function get isPK() : Boolean {return _isPK;}
		public function get isFK() : Boolean {return _isFK;}
		public function get fkTable() : TableView {return _fkTable;}
		
		public function set isPK(value : Boolean) : void 
		{
			if(!_isPK && value)
				TweenMax.to(_text, .3, { tint:0xCC0000 });
			else if(_isPK && !value)
				TweenMax.to(_text, .3, { tint:null });
				
			_isPK = value;
		}
		
		public function set isFK(value : Boolean) : void 
		{
			if(!_isFK && value)
				TweenMax.to(_text, .3, { tint:0xB2AB15 });
			else if(_isFK && !value)
				TweenMax.to(_text, .3, { tint:null });
				
			_isFK = value;
		}
		
		public function get data():CampoDTO
		{	
			_dto.chaveEstrangeira = isFK;
			_dto.chavePrimaria = isPK;
			_dto.descricao = _text.text;
			
			_dto.tabela = isFK ? _fkTable.data : null;
			
			// valor maximo: 10
			_dto.comentario = "sem come";
			_dto.naoNulo = false;
			_dto.autoIncremento = false;
			_dto.tipo = null;
			_dto.valorPadrao = "default";
			
			return _dto;
		}
		
		public function TableAttribute( name:String = null, type:String = null, editNow:Boolean = true, isPK:Boolean = false, isFK:Boolean = false, fkTable:TableView = null ) 
		{
			_dto = new CampoDTO();
			buttonMode = true;
			_text = new TableText(TableText.TYPE_ATTRIBUTE, name || "attribute_"+_i++, editNow);
			//_text.mouseEnabled = false;
			_closeButton = Library.get("icon_close", { scaleX:.8, scaleY:.8, y:10, x:-5, alpha:0, mouseEnabled:false });
			addChild(_closeButton);
			addChild(_text);
			this.isPK = isPK;
			this.isFK = isFK;
			_fkTable = fkTable;
			_text.addEventListener(Event.RESIZE, resizeHandler);
			_text.addEventListener(TableText.EDIT_FINISHED, textEditFinishedHandler);
			
			TweenMax.from(this, .3, {alpha:0});
			
			
			_comboType = new Combo(["Integer", "Long", "Decimal", "Char", "Varchar", "String", "Text", "Binary", "Blob", "Date", "Time", "Datetime", "Year", "Timestamp"], type);
			_comboType.x = _text.width+2;
			_comboType.mouseChildren = false;
			addChild(_comboType);
			
			if(isFK) return;
			_text.mouseEnabled = true;
			_comboType.mouseChildren = true;
			_comboType.addEventListener(MouseEvent.CLICK, typeClickHandler);
			_text.addEventListener(MouseEvent.CLICK, textClickHandler);
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
		}

		public function createFK(tableView : TableView) : TableAttribute 
		{
			return new TableAttribute(tableView.tableName+"_"+_text.text, _comboType.value, false, false, true, tableView);
		}

		public function kill() : void 
		{
			removeEventListener(MouseEvent.CLICK, clickHandler);
			removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			TweenMax.to(_closeButton, .3, {alpha:0, rotation:0, scaleX:.6, scaleY:.6});
			removeChild(_text);
			removeChild(_comboType);
			setTimeout(parent.removeChild, 400, this);
			dispatchEvent(new Event(KILL));
		}

		private function textEditFinishedHandler(event : Event) : void 
		{
			addEventListener(MouseEvent.CLICK, clickHandler);
			buttonMode = true;
			_text.mouseEnabled = true;
		}

		private function rollOutHandler(event : MouseEvent) : void 
		{
			if(isPK) return;
			_closeButton.mouseEnabled = false;
			TweenMax.to(_closeButton, .3, {alpha:0, rotation:0, scaleX:.6, scaleY:.6});
		}

		private function rollOverHandler(event : MouseEvent) : void 
		{
			if(isPK) return;
			_closeButton.mouseEnabled = true;
			TweenMax.to(_closeButton, .3, {alpha:1, rotation:90, scaleX:.8, scaleY:.8});
		}

		private function clickHandler(event : MouseEvent) : void 
		{
			if(event.target == _closeButton)
			{
				kill();
			}
		}

		private function textClickHandler(event : MouseEvent) : void 
		{
			removeEventListener(MouseEvent.CLICK, clickHandler);
			buttonMode = false;
			//_text.mouseEnabled = true;
			_text.edit();
		}

		private function typeClickHandler(event : MouseEvent) : void 
		{
			parent.parent.addChild(parent);
			_comboType.show();
		}

		private function resizeHandler(event : Event) : void 
		{
			_comboType.x = _text.width+2;
			dispatchEvent(new Event(Event.RESIZE));
		}
	}
}
