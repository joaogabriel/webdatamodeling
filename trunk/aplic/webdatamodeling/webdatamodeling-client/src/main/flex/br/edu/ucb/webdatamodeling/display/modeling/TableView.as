package br.edu.ucb.webdatamodeling.display.modeling {
	
	import mx.controls.Alert;
	import br.edu.ucb.webdatamodeling.dto.TipoTabelaDTO;
	import br.com.thalespessoa.utils.Library;
	import br.edu.ucb.webdatamodeling.display.modeling.events.MenuEvent;
	import br.edu.ucb.webdatamodeling.display.modeling.events.TableEvent;
	import br.edu.ucb.webdatamodeling.display.modeling.menu.TableMenu;
	import br.edu.ucb.webdatamodeling.display.modeling.ui.Combo;
	import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gs.TweenMax;
	import gs.easing.Expo;
	
	import mx.collections.ArrayCollection;

	/**
	 * @author usuario
	 */
	public class TableView extends Sprite 
	{
		static public const DRAGGING:String = "dragging";
		static public const START_RELATIONSHIP:String = "startRelationship";
		static public const KILL:String = "kill";
		
		static public var tableTypes:Array;
		static private var _i:uint = 0;

		private var _menu:TableMenu;
		private var _relationships:Array;
		private var _title:TableText;
		private var _id:uint;
		private var _attributes:Array;
		private var _oldMaxField:DisplayObject;
		
		private var _titleBase : Sprite;
		private var _base : Sprite;
		private var _typeCombo:Combo;
		
		private var _plusMenu:Sprite;
		
		private var _centerX:Number;
		private var _centerY:Number;
		private var _dto:TabelaDTO;

		
		public function get attributes() : Array {return _attributes;}
		public function get centerX() : Number {return x + _centerX;}
		public function get centerY() : Number {return y + _centerY;}
		public function get tableName() : String {return _title.text;}
		public function get fk() : Array 
		{
			var r:Array = [];
			for(var i:uint = 0; i<_attributes.length; i++)
				if(TableAttribute(_attributes[i]).isPK)
					r.push(TableAttribute(_attributes[i]).createFK(this));
					
			return r;
		}
		
		public function get pk() : Array 
		{
			var r:Array = [];
			for(var i:uint = 0; i<_attributes.length; i++)
				if(TableAttribute(_attributes[i]).isPK)
					r.push(TableAttribute(_attributes[i]));
					
			return r;
		}
		
		public function get data():TabelaDTO{return _dto;}
		public function get title():String{ return _title.text; }
		
		public function set id(value:Number):void{_dto.id = value;}
		public function set type(value:TipoTabelaDTO):void 
		{
			_typeCombo.value = value.id;
		}

		public function TableView( name:String = null ) 
		{
			_dto = new TabelaDTO;
			_id = _i++;
			_relationships = [];
			_menu = new TableMenu();
			_menu.addEventListener(MenuEvent.SELECT_CREATE_RELATIONSHIP, createRelationshipHandler);
			_menu.addEventListener(MenuEvent.SELECT_DELETE, selectDeleteHandler);
			_menu.addEventListener(MenuEvent.SELECT_EDIT_TITLE, selectEditTitleHandler);
			_menu.addEventListener(MenuEvent.SELECT_PLUS, selectPlusHandler);
			_menu.addEventListener(MenuEvent.SELECT_CLEAR, selectClearHandler);
			addEventListener(MouseEvent.CLICK, clickHandler);
			//addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			create( name );
			if(!name) addAttribute(new TableAttribute("id",null,false,true,false,null,true,true));
			show();
			
			resize(_title);
		}

		public function generateData():TabelaDTO
		{
			var attributes:Array = [];
			var len:uint = _attributes.length;
			
			for(var i:uint=0; i<len; i++) attributes[i] = TableAttribute(_attributes[i]).data;
			
			_dto.comentario = "sem comentário";
			_dto.coordenadaX = x;
			_dto.coordenadaY = y;
			_dto.descricao = _title.text;
			_dto.tipo = _typeCombo.value;
			_dto.campos = new ArrayCollection(attributes);
			
			return _dto;
		}

		public function show():void
		{
			TweenMax.to(_titleBase, .3, { scaleY:1, ease:Expo.easeOut });
			//TweenMax.to(_base, .3, { scaleY:1, ease:Expo.easeOut, delay:.2 });
		}
		
		public function kill():void
		{
			var relationships:Array = _relationships;
			_relationships = null;

			if(relationships)
				for(var i:uint = 0; i<relationships.length; i++)
					RelationshipView(relationships[i]).kill();
				
			for(i=0; i<_attributes.length; i++)
				TweenMax.to(_attributes[i], .3, { alpha:0, delay: _attributes.length*.05 - i*.05 });
			
			_menu = null;
			TweenMax.to(_title, .3, { scaleY:0, ease:Expo.easeOut, delay:.5 });
			TweenMax.to(_base, .3, { scaleY:0, ease:Expo.easeOut, delay:.5 });
			TweenMax.to(_titleBase, .3, { scaleY:0, ease:Expo.easeOut, delay:.7, onComplete:onKill });
			
			dispatchEvent(new Event("kill"));
		}
		

		public function addAttributes(attributes : Array) : void 
		{
			for(var i:uint = 0; i<attributes.length; i++)
				addAttribute(attributes[i]);
		}
		
		public function addAttribute( attribute:TableAttribute ):void
		{
			var len:uint = _attributes.length;
			var i:uint = _attributes.length;
			
			if(attribute.isFK) i = 0;
			/*if(attribute.isPK) i = 0;
			else if(attribute.isFK)
			{
				for(i=0; i<len; i++)	
					if(!TableAttribute(_attributes[i]).isPK) 
						break;
			}*/
			
			attribute.y = 20 + i * 18 + 5;
			_attributes.splice(i,0,attribute);
			
			organizeAttributes();
			
			addChild(attribute);
			attribute.addEventListener(Event.RESIZE, resizeHandler);
			attribute.addEventListener(TableAttribute.KILL, killAttributeHandler);
			attribute.addEventListener(TableAttribute.CHANGE_PK, changePkHandler);
			/*if(attribute.fkTable)
				attribute.fkTable.addEventListener(TableEvent.ADD_PK, addFkHandler);*/
			
			var h:Number = 25 + _attributes.length * 18 + 10;
			TweenMax.to(_base, .5, {height:h, ease:Expo.easeOut});
			TweenMax.to(_plusMenu, .5, {y:h, ease:Expo.easeOut});
			_menu.y = h;
			_centerY = h / 2;
			
			resize(attribute);
		}

		/*private function addFkHandler(event : TableEvent) : void 
		{
			addAttribute(event.attribute.createFK(TableView(event.target)));
		}*/

		internal function addRelationship( relationship:RelationshipView ):void 
		{
			_relationships.push(relationship);
		}

		internal function removeRelationship( relationship:RelationshipView ):void
		{
			if(_relationships && _relationships.indexOf(relationship) > -1)
				_relationships.splice(_relationships.indexOf(relationship), 1);
		}

		private function organizeAttributes() : void 
		{
			var len:uint = _attributes.length;
			var position:Number;
			for(var i :uint = 0; i<len; i++)
			{
				position = 20 + i * 18 + 5;
				TweenMax.to(_attributes[i], .5, {ease:Expo.easeOut, y:position });
			}
		}
		
		private function onKill():void
		{
			if(parent)
				parent.removeChild(this);
		}
		
		private function resize( field:DisplayObject ):void
		{
			var w: uint = _title.width + _typeCombo.width + 7;
			var len: uint = _attributes.length;
			
			_typeCombo.x = _title.x + _title.width + 7;
			
			for(var i:uint=0; i<len; i++)
				w = Math.max(w, _attributes[i].width);
				
			_titleBase.width = Math.max(w + 5, 100);
			_base.width = Math.max(w + 5, 100);
			_centerX = _menu.x = _plusMenu.x = _base.width / 2;
			
			len = _relationships.length;
			for(i=0; i<len; i++)
				_relationships[i].update();
		}

		private function create( name:String ):void
		{
			_base = new Sprite();
			//_base.graphics.beginFill(0xFFCC99);
			_base.graphics.beginFill(0xFFFFFF);
			_base.graphics.drawRect(0, 0, 100, 30);
			_base.graphics.endFill();
			_base.scaleY = 0;
			addChild( _base );
			//base.addEventListener(MouseEvent.MOUSE_DOWN, baseMouseDownHandler);
			
			_titleBase = new Sprite();
			//_titleBase.graphics.beginFill(0xFF9965);
			_titleBase.graphics.beginFill(0x00CBFF);
			_titleBase.graphics.drawRect(0, 0, 100, 25);
			_titleBase.graphics.endFill();
			_titleBase.scaleY = 0;
			_titleBase.buttonMode = true;
			addChild( _titleBase );
			_titleBase.addEventListener(MouseEvent.MOUSE_DOWN, titleMouseDownHandler);
			
			_title = new TableText(TableText.TYPE_TITLE, name || "table_"+_id, !name);
			_title.addEventListener(Event.RESIZE, resizeHandler);
			addChild( _title);
			
			_typeCombo = new Combo(tableTypes, undefined, false);
			_typeCombo.x = _title.x + _title.width + 7;
			_typeCombo.y = 3;
			addChild(_typeCombo);
			
			_plusMenu = Library.get("plus_menu", {alpha:0});
			_menu.x = _plusMenu.x = _base.width / 2;
			_menu.y = _plusMenu.y = 30;
			addChild(_plusMenu);
			_plusMenu.buttonMode = true;
			_plusMenu.addEventListener(MouseEvent.MOUSE_DOWN, baseClickHandler);
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			
			_centerX = 50;
			_centerY = 12;
			 _attributes = [];
			 
			TweenMax.to(this, .3, { glowFilter:{color:0x999999, alpha:.8, blurX:6, blurY:6, strength:2 }});
		}

		private function selectClearHandler(event : MenuEvent) : void 
		{
			var len: int = _attributes.length;
			event.stopImmediatePropagation();
			for(var i:int=len-1; i>=0; i--)
				if(!_attributes[i].isPK && !_attributes[i].isFK)
					_attributes[i].kill();
		}

		private function changePkHandler(event : Event) : void 
		{
			if(TableAttribute(event.target).isPK)
				dispatchEvent(new TableEvent(TableEvent.ADD_PK, TableAttribute(event.target)));
		}

		private function rollOutHandler(event : MouseEvent) : void 
		{
			TweenMax.to(_plusMenu, .3, {alpha:0});
		}

		private function rollOverHandler(event : MouseEvent) : void 
		{
			TweenMax.to(_plusMenu, .3, {alpha:1});
		}

		private function resizeHandler(event : Event) : void 
		{
			resize(DisplayObject( event.target ));
		}

		private function selectDeleteHandler(event : MenuEvent) : void 
		{
			kill();
		}

		private function selectEditTitleHandler(event : MenuEvent) : void 
		{
			_title.edit();
		}

		private function baseClickHandler(event : MouseEvent) : void 
		{
			if(StageModeling.isDrawingRelationship)
				return;
				
			addChild(_menu);
			_menu.show();
		}

		private function createRelationshipHandler(event : MenuEvent) : void 
		{
			dispatchEvent(new MenuEvent(START_RELATIONSHIP, event.data, false ));
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
			startDrag();
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			addEventListener(Event.ENTER_FRAME, draggingHandler);
			TweenMax.to(this, .2, { glowFilter:{color:0x00CBFF, alpha:.8, blurX:6, blurY:6, strength:2}});
			
			var len: uint = _relationships.length;
			for(var i:uint = 0; i<len; i++)
				TweenMax.to(_relationships[i], .2, { glowFilter:{color:0x00CBFF, alpha:.8, blurX:6, blurY:6, strength:2}});
		}

		private function mouseUpHandler(event : MouseEvent) : void 
		{
			stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			removeEventListener(Event.ENTER_FRAME, draggingHandler);
			TweenMax.to(this, .3, { glowFilter:{color:0x999999, alpha:.8, blurX:6, blurY:6, strength:2 }});
			
			var len: uint = _relationships.length;
			for(var i:uint = 0; i<len; i++)
				TweenMax.to(_relationships[i], .3, { glowFilter:{color:null, alpha:0, blurX:0, blurY:0, strength:0}});
		}

		private function selectPlusHandler(event : MenuEvent) : void 
		{
			addAttribute( new TableAttribute() );
		}

		private function killAttributeHandler(event : Event) : void 
		{
			var i: uint = _attributes.indexOf(event.target);
			var yPosition:Number;
			_attributes.splice(i,1);
			var len:uint = _attributes.length;
			for(i; i<len; i++)
			{
				yPosition = 20 + i * 18 + 5;
				TweenMax.to(_attributes[i], .4, {y:yPosition, ease:Expo.easeOut});
			}
			
			var h:Number = _titleBase.height + _attributes.length * 18 + 10;
			TweenMax.to(_base, .5, {height:h, ease:Expo.easeOut});
			TweenMax.to(_plusMenu, .5, {y:h, ease:Expo.easeOut});
			_menu.y = h;
			_centerY = h / 2;
			
			if(!_relationships)
				return;
				
			var len: uint = _relationships.length;
			for(var i:uint=0; i<len; i++)
				_relationships[i].update();
		}
	}
}
