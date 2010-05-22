/*
VERSION: 0.9
DATE: 9/10/2008
DESCRIPTION: 
	Anything you put into this Sprite will scale to fit inside it proportionately and center itself. Resize
	the LiquidBox as much as you want, and the child DisplayObjects will always behave this way.
	You can even set a minimum and/or maximum aspect ratio for the container (the aspect ratios of the
	content will always remain consistent though)

CODED BY: Jack Doyle, jack@greensock.com
Copyright 2008, GreenSock, Inc.
*/

package gs.utils {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Transform;
	import flash.utils.Dictionary;
	
	import gs.*;
	import gs.easing.*;

	public class LiquidBox extends Sprite {
		public static const ALIGN_TOP:String = "top";
		public static const ALIGN_CENTER:String = "center";
		public static const ALIGN_BOTTOM:String = "bottom";
		public static const ALIGN_LEFT:String = "left";
		public static const ALIGN_RIGHT:String = "right";
		protected var _vAlign:String;
		protected var _hAlign:String;
		protected var _width:Number;
		protected var _height:Number;
		protected var _minAspectRatio:Number;
		protected var _maxAspectRatio:Number;
		protected var _content:Array; //When we use swapContent(), we pass in an Array of new children. It is stored here so that it's easy to figure out what the top-most, current content grouping is (some of the old content may be transitioning out with a tween, so we can't just get all the children.)
		protected var _persistDict:Dictionary = new Dictionary(false);
		protected var _forceFillWidth:Array; //populated with DisplayObjects that should be forced to fill the entire width, potentially altering their aspect ratio.
		
		public function LiquidBox($width:Number, $height:Number, $vAlign:String="center", $hAlign:String="center", $minAspectRatio:Number=0, $maxAspectRatio:Number=99999999) {
			super();
			init($width, $height, $vAlign, $hAlign, $minAspectRatio, $maxAspectRatio);
		}
		
		public function init($width:Number, $height:Number, $vAlign:String="center", $hAlign:String="center", $minAspectRatio:Number=0, $maxAspectRatio:Number=99999999):void {
			_width = $width;
			_height = $height;
			_vAlign = $vAlign;
			_hAlign = $hAlign;
			_minAspectRatio = $minAspectRatio;
			_maxAspectRatio = $maxAspectRatio;
			_forceFillWidth = [];
			_content = [];
			this.graphics.clear();
			this.graphics.beginFill(0x000000, 0);
			this.graphics.drawRect(0, 0, $width, $height);
			this.graphics.endFill();
			if (this.numChildren != 0) {
				redraw();
			}
		}
		
		public function replaceContent($newContent:Array, $crossfadeDuration:Number=0):void {
			var old:Array = _content;
			var i:uint;	
			if ($crossfadeDuration == 0) {
				removeContent(old);
			} else if (_content.length != 0) {
				TweenLite.to(old[i], $crossfadeDuration, {autoAlpha:0, ease:Quad.easeOut, onComplete:removeContent, onCompleteParams:[old]});
				for (i = old.length - 1; i > 0; i--) {
					TweenLite.to(old[i], $crossfadeDuration, {autoAlpha:0, ease:Quad.easeOut});
				}
			}
			for (i = 0; i < $newContent.length; i++) {
				super.addChild($newContent[i]);
				if ($crossfadeDuration == 0) {
					$newContent[i].visible = true;
					$newContent[i].alpha = 1;
				} else {
					$newContent[i].alpha = 0;
					TweenLite.to($newContent[i], $crossfadeDuration, {autoAlpha:1, ease:Quad.easeOut});
				}
			}
			redraw();
			_content = $newContent;
		}
		
		public function setChildPersist($child:DisplayObject, $persist:Boolean=true):void {
			_persistDict[$child] = $persist;
		}
		
		public function setChildForceFillWidth($child:DisplayObject, $forceFillWidth:Boolean=true):void {
			for (var i:int = _forceFillWidth.length - 1; i > -1; i--) {
				if (_forceFillWidth[i].mc == $child) {
					if (!$forceFillWidth) {
						_forceFillWidth.splice(i, 1);
					} else {
						return;
					}
				}
			}
			if ($forceFillWidth) {
				_forceFillWidth.push({mc:$child, wRatio:$child.width / _width});
				$child.width = _width;
				$child.x = 0;
			}
		}
		
		public function removeContent($children:Array):void {
			for (var i:int = $children.length - 1; i > -1; i--) {
				if (_persistDict[$children[i]] != true && $children[i].parent == this) {
					this.removeChild($children[i]);
				}		
			}
		}
		
		public function redraw():void {
			var factor:Number = this.scaleY / this.scaleX;
			var w:Number = _width;
			var h:Number = _height;
			var ratio:Number = (w * this.scaleX) / (h * this.scaleY);
			if (ratio < _minAspectRatio) {
				h = ((w * this.scaleX) / _minAspectRatio) / this.scaleY;
			} else if (ratio > _maxAspectRatio) {
				w = ((h * this.scaleY) * _maxAspectRatio) / this.scaleX;
			}
			var xDif:Number = _width - w;
			var yDif:Number = _height - h;
			ratio = (w / h) / factor;
			var curChild:DisplayObject, childRatio:Number, i:int;
			
			for (i = _forceFillWidth.length - 1; i > -1; i--) {
				//_forceFillWidth[i].mc.width *= _forceFillWidth[i].wRatio; //reverts
			}
			
			for (i = this.numChildren - 1; i > -1; i--) {
				curChild = this.getChildAt(i);
				childRatio = (curChild.width / curChild.scaleX) / (curChild.height / curChild.scaleY);
				if (childRatio > ratio) { //wider
					curChild.width = w;
					curChild.height = (w / childRatio) / factor;
					curChild.x = (_hAlign == ALIGN_CENTER) ? xDif / 2 : (_hAlign == ALIGN_RIGHT) ? xDif : 0;
					curChild.y = (_vAlign == ALIGN_CENTER) ? (yDif + (h - curChild.height)) / 2 : (_vAlign == ALIGN_BOTTOM) ? yDif + (h - curChild.height) : 0;
					
				} else { //taller
					curChild.height = h;
					curChild.width = (h * childRatio) * factor;
					curChild.x = (_hAlign == ALIGN_CENTER) ? (xDif + (w - curChild.width)) / 2 : (_hAlign == ALIGN_RIGHT) ? xDif + (w - curChild.width) : 0;
					curChild.y = (_vAlign == ALIGN_CENTER) ? yDif / 2 : (_vAlign == ALIGN_BOTTOM) ? yDif : 0;
				}				
			}
					
			for (i = _forceFillWidth.length - 1; i > -1; i--) {
				_forceFillWidth[i].wRatio = _forceFillWidth[i].mc.width / _width;
				_forceFillWidth[i].mc.width = _width;
				_forceFillWidth[i].mc.x = 0;
			}
		}
		
		override public function addChild($child:DisplayObject):DisplayObject {
			var c:DisplayObject = super.addChild($child);
			redraw();
			return c;
		}
		
		override public function addChildAt($child:DisplayObject, $index:int):DisplayObject {
			var c:DisplayObject = super.addChildAt($child, $index);
			redraw();
			return c;
		}
		
//---- GETTERS / SETTERS --------------------------------------------------------------------------------------------
		
		override public function set width($n:Number):void {
			super.width = $n;
			redraw();
		}
		override public function set height($n:Number):void {
			super.height = $n;
			redraw();
		}
		override public function set scaleX($n:Number):void {
			super.scaleX = $n;
			redraw();
		}
		override public function set scaleY($n:Number):void {
			super.scaleY = $n;
			redraw();
		}
		override public function set transform($t:Transform):void {
			super.transform = $t;
			redraw();
		}
		public function get vAlign():String {
			return _vAlign;
		}
		public function set vAlign($s:String):void {
			_vAlign = $s;
			redraw();
		}
		public function get hAlign():String {
			return _hAlign;
		}
		public function set hAlign($s:String):void {
			_hAlign = $s;
			redraw();
		}
		public function get content():Array {
			return _content;
		}
		public function set content($a:Array):void {
			replaceContent($a, 0);
		}
		
	}
}