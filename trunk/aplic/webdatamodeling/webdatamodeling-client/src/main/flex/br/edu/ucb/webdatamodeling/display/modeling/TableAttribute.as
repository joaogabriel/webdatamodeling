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
		static public const CHANGE_PK : String = "changePK";
		static public const CHANGE_TYPE : String = "changeType";
		
		static public var types:Array;
		
		static private var _i:uint = 0;

		private var _text:TableText;
		private var _isPK:Boolean;
		private var _isFK:Boolean;
		private var _isNN:Boolean;
		private var _isINC:Boolean;
		private var _fkTable:TableView;
		private var _dto : CampoDTO;
		private var _fk:TableAttribute;
		
		private var _closeButton:Sprite;
		private var _comboType:Combo;
		private var _pkIcon:Sprite;
		private var _incIcon : Sprite;
		private var _nnIcon : Sprite;

		override public function get width():Number{return super.width - 20;}
		
		public function get comboType() : Combo {return _comboType;}
		public function get isPK() : Boolean {return _isPK;}
		public function get isFK() : Boolean {return _isFK;}
		public function get fkTable() : TableView {return _fkTable;}
		public function get isNN() : Boolean {return _isNN;}
		public function get isINC() : Boolean {return _isINC;}
		public function get fk() : TableAttribute {return _fk;}
		public function set fk(value : TableAttribute) : void {_fk = value;}
		
		public function set isNN(value : Boolean) : void 
		{
			if(!_isNN && value)
				_nnIcon.alpha = 1;
			else if(_isNN && !value)
				_nnIcon.alpha = .2;
				
			_isNN = value;
		}
		
		public function set isINC(value : Boolean) : void 
		{
			if(!_isINC && value)
				_incIcon.alpha = 1;
			else if(isINC && !value)
				_incIcon.alpha = .2;
				
			_isINC = value;
		}
		
		public function set isPK(value : Boolean) : void 
		{
			if(!isFK)
			{
				if(!_isPK && value)
					TweenMax.to(_text, .3, { tint:0xCC0000 });
				else if(_isPK && !value)
					TweenMax.to(_text, .3, { tint:null });
			}
				
			TweenMax.killTweensOf(_pkIcon);
			if(value)
				TweenMax.to(_pkIcon, .1, { tint:null, alpha:1 });
			else
				TweenMax.to(_pkIcon, .1, { tint:0xCCCCCC, alpha:.2 });
				
			_isPK = value;
			
			dispatchEvent(new Event(CHANGE_PK));
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
			//_dto.chaveEstrangeira = isFK;
			_dto.chavePrimaria = isPK;
			_dto.descricao = _text.text;
			
			_dto.tabelaEstrangeira = isFK ? _fkTable.data : null;
			
			_dto.naoNulo = _isNN;
			_dto.autoIncremento = _isINC;
			_dto.tipo = _comboType.value;
			
			return _dto;
		}
		
		public function TableAttribute( name:String = null, type:Number = undefined, editNow:Boolean = true, isPK:Boolean = false, isFK:Boolean = false, fkTable:TableView = null, isNN:Boolean = false, isINC:Boolean = false ) 
		{
			_dto = new CampoDTO();
			buttonMode = true;
			_text = new TableText(TableText.TYPE_ATTRIBUTE, name || "attribute_"+_i++, editNow);
			//_text.mouseEnabled = false;
			
			addChild(_text);
			_fkTable = fkTable;
			_text.addEventListener(Event.RESIZE, resizeHandler);
			_text.addEventListener(TableText.EDIT_FINISHED, textEditFinishedHandler);
			/*
			_len = new TableText(TableText.TYPE_ATTRIBUTE, "100", false);
			_len.alpha = .2;
			addChild(_len);*/
			
			TweenMax.from(this, .3, {alpha:0});
			
			_comboType = new Combo(types, type);
			_comboType.mouseChildren = false;
			_comboType.addEventListener(Event.CHANGE, changeComboTypes);
			addChild(_comboType);
			
			_pkIcon = Library.getAndAdd("icon_PK", this, { y:1, mouseEnabled:false } );
			_closeButton = Library.get("icon_close_little", { scaleX:.8, scaleY:.8, y:10, x:-10, alpha:0, mouseEnabled:false });
			addChild(_closeButton);
			_incIcon = Library.getAndAdd("icon_inc", this, { x:_pkIcon.x+_pkIcon.width+2, y:5, alpha:.2 } );
			_nnIcon = Library.getAndAdd("icon_notn", this, { x:_incIcon.x+_incIcon.width+1, y:5, alpha:.2 } );
			_text.x=_nnIcon.x+_nnIcon.width+3;
			_comboType.x = _text.x+ _text.width+2;
			//_len.x = _comboType.x + _comboType.width + 2;
			
			this.isPK = isPK;
			this.isFK = isFK;
			this.isNN = isNN;
			
			if(!isPK)	TweenMax.to(_pkIcon, 0, { tint:0xCCCCCC, alpha:.2 });
			
			_text.mouseEnabled = true;
			_pkIcon.addEventListener(MouseEvent.CLICK, pkClickHandler);
			_text.addEventListener(MouseEvent.CLICK, textClickHandler);
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			
			if(isFK) return;

			this.isINC = isINC;
			_comboType.mouseChildren = true;
			//_comboType.addEventListener(MouseEvent.CLICK, typeClickHandler);
			_nnIcon.addEventListener(MouseEvent.CLICK, nnClickHandler);
			_incIcon.addEventListener(MouseEvent.CLICK, incClickHandler);
		}

		public function createFK(tableView : TableView) : TableAttribute 
		{
			//var fk:TableAttribute = 
			//addEventListener(CHANGE_PK, fk.disableFKHandler);

			_fk = new TableAttribute(tableView.tableName+"_"+_text.text, _comboType.value, false, false, true, tableView, true, false);
			addEventListener(CHANGE_TYPE, changeType);
			return _fk;
		}

		private function changeType(event : String) : void 
		{
			if(_fk)
			{
				_fk.comboType.value = comboType.value;
				_fk.comboType.length = comboType.length;
			}
			else
				removeEventListener(CHANGE_TYPE, changeType);
		}

		/*
		public function disableFKHandler(event:Event):void
		{
			if(TableAttribute(event.target).isPK) return;
			event.target.removeEventListener(CHANGE_PK, disableFKHandler);
			kill();
		}
		*/
		public function kill() : void 
		{	
			//if(isPK) return;
			
			removeEventListener(MouseEvent.CLICK, clickHandler);
			removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			TweenMax.to(_closeButton, .3, {alpha:0, rotation:0, scaleX:.6, scaleY:.6});
			removeChild(_text);
			removeChild(_comboType);
			removeChild(_incIcon);
			removeChild(_nnIcon);
			removeChild(_pkIcon);
			parent.removeChild(this);
			//setTimeout(parent.removeChild, 400, this);
			dispatchEvent(new Event(KILL));
		}

		private function changeComboTypes(event : Event) : void 
		{
			dispatchEvent(new Event(CHANGE_TYPE));
			dispatchEvent(new Event(Event.RESIZE));
		}

		private function textEditFinishedHandler(event : Event) : void 
		{
			addEventListener(MouseEvent.CLICK, clickHandler);
			buttonMode = true;
			_text.mouseEnabled = true;
		}

		private function rollOutHandler(event : MouseEvent) : void 
		{
			_pkIcon.mouseEnabled = false;
			TweenMax.killTweensOf(_pkIcon);
			TweenMax.killTweensOf(_nnIcon);
			TweenMax.killTweensOf(_incIcon);
			
			//TweenMax.to(_pkIcon, .3, { alpha:0 });
			//TweenMax.to(_nnIcon, .3, { alpha:0 });
			//TweenMax.to(_incIcon, .3, { alpha:0 });
			
			_closeButton.mouseEnabled = false;
			TweenMax.to(_closeButton, .3, {alpha:0, rotation:0, scaleX:.6, scaleY:.6});
		}

		private function rollOverHandler(event : MouseEvent) : void 
		{
			_pkIcon.mouseEnabled = true;
			//TweenMax.to(_pkIcon, .3, { alpha:1 });
			//TweenMax.to(_incIcon, .3, { alpha:1 });
			//TweenMax.to(_nnIcon, .3, { alpha:1 });

			_closeButton.mouseEnabled = true;
			TweenMax.to(_closeButton, .3, {alpha:1, rotation:90, scaleX:.8, scaleY:.8});
		}

		private function clickHandler(event : MouseEvent) : void 
		{
			if(event.target == _closeButton)
			{
				kill();
				dispatchEvent(new Event(Event.CLOSE));
			}
		}

		private function pkClickHandler(event : MouseEvent) : void 
		{
			isPK = !_isPK;
		}

		private function incClickHandler(event : MouseEvent) : void 
		{
			if(_isINC)
				_incIcon.alpha = .2;
			else
				_incIcon.alpha = 1;
				
			isINC = !_isINC;
		}

		private function nnClickHandler(event : MouseEvent) : void 
		{
			if(_isNN)
				_nnIcon.alpha = .2;
			else
				_nnIcon.alpha = 1;
				
			isNN = !_isNN;
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
			_comboType.x = _text.x + _text.width+2;
			dispatchEvent(new Event(Event.RESIZE));
		}
	}
}
