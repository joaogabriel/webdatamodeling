package br.edu.ucb.webdatamodeling.display.modeling.ui {
	import br.edu.ucb.webdatamodeling.dto.TipoCampoDTO;
	import flash.events.Event;

	import gs.easing.Cubic;
	import gs.easing.Expo;
	import gs.TweenMax;

	import flash.events.MouseEvent;
	import flash.display.DisplayObject;

	import br.com.thalespessoa.utils.DisplayUtils;
	import br.edu.ucb.webdatamodeling.display.modeling.TableText;
	import flash.display.Sprite;
	
	/**
	 * @author usuario
	 */
	public class Combo extends Sprite 
	{
		private var _track:DisplayObject;
		private var _containerItems:Sprite;
		private var _nameItems:Array;
		private var _trackPosition:Number;
		private var _trackHeight:Number;
		private var _selected:TableText;
		private var _selectedDTO:*;
		private var _items:Array;
		private var _index : uint;
		private var _len : TableText;
		private var _useLen:Boolean;

		public function get value():*{ return _selectedDTO; }
		public function get length():Number{ return Number(_len.text); }
		
		public function set value(value:Number):void
		{ 
			for(var i:uint=0; i<_nameItems.length; i++)
				if(_nameItems[i].id == value)
					selectByIndex(i);
		}
		public function set length(value:Number):void{ _len.text = String(value); }
		
		
		public function Combo( items:Array, initName:Number = undefined, useLen:Boolean = true ) 
		{
			_useLen = useLen;
			_nameItems = items;
			create();
			_index = 0;
			
			if(initName)
				for(var i:uint=0; i<items.length; i++)
					if(items[i].id == initName)
						selectByIndex(i);
		}

		public function show() : void 
		{
			parent.addChild(this);
			parent.parent.addChild(parent);
			parent.parent.parent.addChild(parent.parent);
			//Sprite(parent).buttonMode = false;
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			TweenMax.to(_track, .3, { scaleY:1, y:_trackPosition, ease:Expo.easeOut  });
			TweenMax.to(_containerItems.mask, .3, { height:_trackHeight, y:_trackPosition, delay:.1, ease:Cubic.easeInOut});
			TweenMax.to(_selected, .3, {tint:null});
			TweenMax.to(_containerItems.getChildAt(0), .3, {alpha:1});
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			
			if(_useLen)
				TweenMax.to(_len, .3, { alpha:0 });
		}

		private function hide():void
		{
			//Sprite(parent).buttonMode = true;
			TweenMax.to(_track, .3, { scaleY:0, y:7, ease:Expo.easeOut, delay:.1  });
			TweenMax.to(_containerItems.mask, .4, { height:15, y:2, ease:Expo.easeOut});
			TweenMax.to(_selected, .3, {tint:0xCCCCCC});
			TweenMax.to(_containerItems.getChildAt(0), .3, {alpha:0});
			removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			
			if(_useLen)
			{
				TweenMax.to(_len, .3, { alpha:.2 });
				alignLen();
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}

		private function create() : void 
		{
			var len:uint = _nameItems.length;
			var item:TableText;
			_containerItems = new Sprite;
			_items = [];
			
			for(var i:uint=0; i<len; i++)
			{
				item = new TableText(TableText.TYPE_OTHER, _nameItems[i].descricao, false);
				item.y = i*15;
				_items[i] = item;
				_containerItems.addChild(item);			
				TweenMax.to(item, 0, {tint:0xCCCCCC});
				item.mouseEnabled = true;
				item.addEventListener(MouseEvent.CLICK, itemClickHandler);
				
				if(!_selected)
				{
					_selectedDTO = _nameItems[i];
					_selected = item;
				}
			}
			
			_containerItems.addChildAt(DisplayUtils.drawRect(_containerItems.width + 2, _containerItems.height+2, 0xFFFFFF, {x:1, y:-1, alpha:0 }),0);
			addChild(_track = DisplayUtils.drawRect(_containerItems.width + 1, _containerItems.height*2-15, 0x999999, { alpha:.4, x:0 } ));
			addChild(_containerItems);
			
			_trackPosition = -_containerItems.height+15;
			_trackHeight = _track.height;
			_containerItems.mask = DisplayUtils.drawRect(_containerItems.width, 15, 0xFF0000, {y:2});
			addChild(_containerItems.mask);
			_track.scaleY = 0;
			
			_containerItems.addEventListener( MouseEvent.CLICK, clickConteinerHandler );
			
			if(!_useLen) return;
			
			_len = new TableText(TableText.TYPE_OTHER, "0", false, "0-9");
			_len.alpha = .2;
			_len.mouseEnabled = true;
			addChild(_len);
			alignLen();
			
			_len.addEventListener( MouseEvent.CLICK, clickLenHandler);
			_len.addEventListener( TableText.EDIT_FINISHED, editLenFinishedHandler);
		}

		private function alignLen() : void 
		{
			_len.x = _selected.x + _selected.width + 2;
		}

		private function selectByIndex( index:uint ):void
		{
			_index = index;
			TweenMax.to(_selected, 0, {tint:0xCCCCCC});
			_selected = _items[index];
			_selectedDTO = _nameItems[index];
			
			checkLen();
				
			alignLen();
			//TweenMax.to(_selected, 0, {tint:null});
			_containerItems.y = -_selected.y;
		}

		private function clickLenHandler(event : MouseEvent) : void 
		{
			_len.edit();
		}

		private function editLenFinishedHandler(event : Event) : void 
		{
			_len.mouseEnabled = true;
			checkLen();
		}

		private function clickConteinerHandler(event : MouseEvent) : void 
		{
			show();
		}

		private function mouseWheelHandler(event : MouseEvent) : void 
		{
			if(event.delta > 0)
				_index = Math.max(_index-1, 0);
			else
				_index = Math.min(_index+1, _items.length-1);
				
			selectByIndex(_index);
		}
		
		private function itemClickHandler(event : MouseEvent) : void 
		{
			TweenMax.to(_selected, .3, {tint:0xCCCCCC});
			_selected = TableText(event.target);
			_selectedDTO = _nameItems[_items.indexOf(TableText(event.target))];

			checkLen();
			
			TweenMax.to(_selected, .3, {tint:null});
			TweenMax.to(_containerItems, .4, { y:-_selected.y, ease:Expo.easeOut});
			_index = _items.indexOf(_selected);
		}

		private function checkLen() : void 
		{
			if(!_useLen) return;
			
			if(Number(_len.text)<_selectedDTO.valorMinimo)
				_len.text = String(_selectedDTO.valorMinimo);
			else if(Number(_len.text)>_selectedDTO.valorMaximo)
				_len.text = String(_selectedDTO.valorMaximo);
				
			
			dispatchEvent(new Event(Event.CHANGE));
		}

		private function rollOutHandler(event : MouseEvent) : void 
		{
			removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			hide();
		}
	}
}
