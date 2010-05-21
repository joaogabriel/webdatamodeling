package br.edu.ucb.webdatamodeling.display.modeling.ui {
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
		private var _items:Array;
		
		public function get value():String{ return _selected.text; }
		
		public function Combo( items:Array, initName:String = null ) 
		{
			_nameItems = items;
			create();
			
			if(initName)
				selectByIndex(items.indexOf(initName));
		}

		public function show() : void 
		{
			parent.parent.addChild(parent);
			//Sprite(parent).buttonMode = false;
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			TweenMax.to(_track, .3, { scaleY:1, y:_trackPosition, ease:Expo.easeOut  });
			TweenMax.to(_containerItems.mask, .3, { height:_trackHeight, y:_trackPosition, delay:.1, ease:Cubic.easeInOut});
			TweenMax.to(_selected, .3, {tint:null});
		}

		private function hide():void
		{
			//Sprite(parent).buttonMode = true;
			TweenMax.to(_track, .3, { scaleY:0, y:7, ease:Expo.easeOut, delay:.1  });
			TweenMax.to(_containerItems.mask, .4, { height:15, y:2, ease:Expo.easeOut});
			TweenMax.to(_selected, .3, {tint:0xCCCCCC});
		}

		private function create() : void 
		{
			var len:uint = _nameItems.length;
			var item:TableText;
			_containerItems = new Sprite;
			_items = [];
			
			for(var i:uint=0; i<len; i++)
			{
				item = new TableText(TableText.TYPE_ATTRIBUTE, _nameItems[i], false);
				item.y = i*15;
				_items[i] = item;
				_containerItems.addChild(item);			
				TweenMax.to(item, 0, {tint:0xCCCCCC});
				item.mouseEnabled = true;
				item.addEventListener(MouseEvent.CLICK, itemClickHandler);
				
				if(!_selected)
					_selected = item;
			}
			
			_containerItems.addChildAt(DisplayUtils.drawRect(_containerItems.width + 2, _containerItems.height+2, 0xFFFFFF, {x:1, y:-1 }),0);
			addChild(_track = DisplayUtils.drawRect(_containerItems.width + 1, _containerItems.height*2-15, 0x999999, { alpha:.4, x:0 } ));
			addChild(_containerItems);
			
			_trackPosition = -_containerItems.height+15;
			_trackHeight = _track.height;
			_containerItems.mask = DisplayUtils.drawRect(_containerItems.width, 15, 0xFF0000, {y:2});
			addChild(_containerItems.mask);
			_track.scaleY = 0;
		}
		
		private function selectByIndex( index:uint ):void
		{
			TweenMax.to(_selected, 0, {tint:0xCCCCCC});
			_selected = _items[index];
			//TweenMax.to(_selected, 0, {tint:null});
			_containerItems.y = -_selected.y;
		}
		
		private function itemClickHandler(event : MouseEvent) : void 
		{
			TweenMax.to(_selected, .3, {tint:0xCCCCCC});
			_selected = TableText(event.target);
			TweenMax.to(_selected, .3, {tint:null});
			TweenMax.to(_containerItems, .4, { y:-_selected.y, ease:Expo.easeOut});
		}

		private function rollOutHandler(event : MouseEvent) : void 
		{
			removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			hide();
		}

		private function clickHandler(event : MouseEvent) : void 
		{
			show();
		}
	}
}
