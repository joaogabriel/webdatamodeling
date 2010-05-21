package br.edu.ucb.webdatamodeling.display.modeling.menu {
	import flash.utils.setTimeout;
	import gs.easing.Cubic;

	import flash.events.MouseEvent;
	import br.edu.ucb.webdatamodeling.display.modeling.events.MenuEvent;

	import gs.easing.Expo;
	import gs.TweenMax;

	import flash.display.Sprite;

	/**
	 * @author usuario
	 */
	internal class BaseMenu extends Sprite 
	{
		static private var _menuOpened:BaseMenu;
		
		//protected var _items:Vector.<MenuItem>;
		protected var _items:Array;
		
	   	private var _radius:uint;
	   	private var _initialDegree:Number;
		
		public function get degree() : Number {return _initialDegree;}
		public function set degree(value : Number) : void {_initialDegree = value;}
		
		
		public function BaseMenu() 
		{
			_radius = _items.length * 10;
	   		draw();
			TweenMax.to(this, .3, { glowFilter:{color:0xFFFFFF, alpha:.8, blurX:10, blurY:10, strength:3 }});
		}
		
		public function show():void
		{
			if(_menuOpened)
				_menuOpened.hide();
			
			_menuOpened = this;
			alpha = 0;
			degree = 4;
			scaleX = scaleY = .1;
			
			TweenMax.killTweensOf(this);
			TweenMax.to(this, .5, {alpha:1, degree:0, onUpdate:draw, ease:Expo.easeOut, scaleX:1, scaleY:1 });
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}

		private function mouseMoveHandler(event : MouseEvent) : void 
		{
			if(Math.abs(mouseX) > _radius*1.5 || Math.abs(mouseY) > _radius*1.5)
				hide();
		}

		public function hide():void
		{
			if(stage)
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				
			TweenMax.killTweensOf(this);
			TweenMax.to(this, .5, {alpha:0, degree:4, onUpdate:draw, ease:Cubic.easeOut, scaleX:.1, scaleY:.1, onComplete:onHide });
		}
		
		private function onHide():void
		{
			if(parent)
				parent.removeChild(this);
		}
		
		private function draw():void
		{
	    	var radian:Number;
	   		var degree:Number = 360 / _items.length;
	   		
			for(var i:uint = 0; i<_items.length; i++)
			{
				radian = (degree*i/180)*Math.PI + _initialDegree;
				_items[i].x = Math.cos(radian)*_radius;
				_items[i].y = -Math.sin(radian)*_radius;
				addChild(_items[i]);
			}
		}
	}
}
