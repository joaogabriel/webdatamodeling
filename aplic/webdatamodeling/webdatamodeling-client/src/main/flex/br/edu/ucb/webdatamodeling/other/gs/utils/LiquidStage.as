/*
VERSION: 0.993
DATE: 1/21/2009
ACTIONSCRIPT VERSION: 3.0
UPDATES & MORE DETAILED DOCUMENTATION AT: http://blog.greensock.com/liquidstage/
DESCRIPTION:
	LiquidStage allows you to "pin" DisplayObjects to reference points on the stage or in other DisplayObjects so that when the stage is resized, 
	the DisplayObjects are repositioned and stay exactly the same distance from the reference point(s) they're registered to. It also allows you to 
	define another pin point horizontally and/or vertically which will change the width/height of the DisplayObject when the stage is resized, stretching
	it visually. For example, maybe you want a logo Sprite to always maintain a particular distance from the bottom right corner. Or maybe you'd like a bar to snap to
	the bottom of the screen and stretch horizontally to fill the bottom of the stage. 
	
	LiquidStage is NOT a layout manager. It just takes your original layout, remembers how far your pinned DisplayObjects are from their respective pins,
	and alters the x/y coordinates when the stage resizes (and their width/height if you use the LiquidStage.stretchObject() method) so that they
	maintain their relative distance regardless of nesting. It sounds pretty simple, but there are some handy features like:
	
		- Your DisplayObjects do not need to be at the root level - LiquidStage will compensate for nesting even if the DisplayObject's
		  anscestors are offset (not at the 0,0 position). 
		- Repositioning/Resizing values are relative so if you pin an object and then move it, LiquidStage will honor that new position.
		- Not only can you pin things to the TOP_LEFT, TOP_CENTER, TOP_RIGHT, RIGHT_CENTER, BOTTOM_RIGHT, BOTTOM_CENTER, BOTTOM_LEFT, LEFT_CENTER, 
		  and CENTER, but you can create your own custom PinPoints in any DisplayObject. 
		- LiquidStage leverages the TweenLite engine to allow for animated transitions. You can define the duration of the transition and 
		  the easing equation for each DisplayObject individually.
		- If there are any TweenLite/FilterLite/Max instances that are tweening the x/y coordinates of an object, LiquidStage will
		  seamlessly integrate itself with the existing tween(s) by updating their end values on the fly.
		- x and y coordinates are always snapped to whole pixel values, so you don't need to worry about mushy text or distorted images.
		- LiquidStage does NOT force you to align the stage to the upper left corner - it will honor whatever StageAlign you choose.
		- Optionally define a minimum width/height to prevent objects from repositioning when the stage gets too small.
		- LiquidStage only does its work when the stage resizes, so it's not constantly draining CPU cycles and hurting performance.
		  
	
KEY METHODS:
	- LiquidStage.init(stage:Stage, baseWidth:uint, baseHeight:uint, minWidth:uint, minHeight:uint):void
	- LiquidStage.pinObject(object:DisplayObject, point:PinPoint, accordingToBase:Boolean, duration:Number, ease:Function):void
	- LiquidStage.pinObjects(objects:Array, point:PinPoint, accordingToBase:Boolean, duration:Number, ease:Function):void
	- LiquidStage.stretchObject(object:DisplayObject, primaryPoint:PinPoint, xStretchPoint:PinPoint, yStretchPoint:PinPoint, accordingToBase:Boolean, duration:Number, ease:Function):void
	- LiquidStage.releaseObject(object:DisplayObject):void
	- LiquidStage.update():void
	
	
EXAMPLES: 
	To make the logo_mc Sprite pin itself to the bottom right corner of your SWF that's built to a 550x400 dimension, you'd do:
	
		import gs.utils.LiquidStage;
		
		LiquidStage.init(this.stage, 550, 400);
		LiquidStage.pinObject(logo_mc, LiquidStage.BOTTOM_RIGHT);
	
	To pin the logo_mc as mentioned above and make the bottomBar_mc Sprite pin itself to both the bottom left and bottom right corners 
	so that it stretches as the window resizes in a SWF that's built to a 550x400 dimension, and set the minimum width and height to 
	that base size (550x400) so that it cannot collapse to a smaller size than that, and animate the transition over the course of 
	1.5 seconds with an Elastic.easeOut ease, do:
		
		import gs.utils.LiquidStage;
		import gs.easing.Elastic;
		import flash.display.*;
		
		this.stage.align = StageAlign.TOP_LEFT;
		LiquidStage.init(this.stage, 550, 400, 550, 400);
		LiquidStage.pinObject(logo_mc, LiquidStage.BOTTOM_RIGHT);
		LiquidStage.stretchObject(bottomBar_mc, LiquidStage.BOTTOM_LEFT, LiquidStage.BOTTOM_RIGHT, null, true, 1.5, Elastic.easeOut);
		
	To create a custom PinPoint in the "videoDisplay" Sprite and pin the "videoControls" to that custom point so that videoControls
	always maintains the same distance from its registration point to the PinPoint inside videoDisplay, you'd do:
	
		import gs.utils.LiquidStage;
		import gs.utils.PinPoint;
		
		LiquidStage.init(this.stage, 550, 400);
		var myCustomPinPoint:PinPoint = new PinPoint(100, 200, videoDisplay);
		LiquidStage.pinObject(videoControls, myCustomPinPoint);

		
NOTES:
	- This class will add about 5k to your SWF + 3k from TweenLite for a total of roughly 7k.
	- When testing in the Flash IDE, please be aware of the fact that there is a BUG in Flash that can cause it to incorrectly
	  report the height of the SWF as 100 pixels LESS than what it should be, but this ONLY affects testing in the IDE. When
	  you test the same SWF in a browser or in the standalone projector, it will render correctly.
	- You need to set up your objects on the stage initially with the desired relative distance between them; LiquidStage doesn't 
	  completely reposition them initially. For example, if you want a bar that spans the width of the stage, but you set it up
	  on the stage so that there are 20 pixels on each side of it and then do LiquidStage.stretchObject(), it'll always have 20 pixels 
	  on each side of it.
	- If a DisplayObject is not in the display list (has no parent), LiquidStage will ignore it until it is back in the display list.

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/

package gs.utils {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public class LiquidStage {
		public static const VERSION:Number = 0.992;
		
		private static var _stageBox:Sprite = new Sprite();
		
		public static var TOP_LEFT:PinPoint = new PinPoint(0, 0, _stageBox);
		public static var TOP_CENTER:PinPoint = new PinPoint(0, 0, _stageBox);
		public static var TOP_RIGHT:PinPoint = new PinPoint(0, 0, _stageBox);
		public static var BOTTOM_LEFT:PinPoint = new PinPoint(0, 0, _stageBox);
		public static var BOTTOM_CENTER:PinPoint = new PinPoint(0, 0, _stageBox);
		public static var BOTTOM_RIGHT:PinPoint = new PinPoint(0, 0, _stageBox);
		public static var LEFT_CENTER:PinPoint = new PinPoint(0, 0, _stageBox);
		public static var RIGHT_CENTER:PinPoint = new PinPoint(0, 0, _stageBox);
		public static var CENTER:PinPoint = new PinPoint(0, 0, _stageBox);
		public static var NONE:PinPoint = new PinPoint(0, 0, _stageBox); //To avoid errors where parameters require a Point and Flash won't allow simply null.
		
		private static var _points:Object = {}; //contains a property for each point (topLeft, bottomRight, etc.), each having current, previous, and base properties indicating the offsets from the stage registration point.
		private static var _dispatcher:EventDispatcher = new EventDispatcher();
		private static var _pending:Array = [];
		private static var _initted:Boolean;
		private static var _items:Array = [];
		private static var _updateables:Array = [];
		private static var _xStageAlign:uint; //0 = left, 1 = center, 2 = right
		private static var _yStageAlign:uint; //0 = top, 1 = center, 2 = bottom
		
		public static var minWidth:uint;
		public static var minHeight:uint;
		public static var stage:Stage;
		
		public static function init($stage:Stage, $baseWidth:uint, $baseHeight:uint, $minWidth:uint=999999, $minHeight:uint=999999):void {
			if (!_initted && $stage != null) {
				LiquidStage.stage = $stage;
				LiquidStage.minWidth = $minWidth;
				LiquidStage.minHeight = $minHeight;
				
				_stageBox.graphics.beginFill(0x0000FF, 0.5);
				_stageBox.graphics.drawRect(0, 0, $baseWidth, $baseHeight);
				_stageBox.graphics.endFill();
				_stageBox.name = "__stageBox_mc";
				_stageBox.visible = false;
				
				TOP_CENTER.init($baseWidth / 2, 0);
				TOP_RIGHT.init($baseWidth, 0);
				RIGHT_CENTER.init($baseWidth, $baseHeight / 2);
				BOTTOM_RIGHT.init($baseWidth, $baseHeight);
				BOTTOM_CENTER.init($baseWidth / 2, $baseHeight);
				BOTTOM_LEFT.init(0, $baseHeight);
				LEFT_CENTER.init(0, $baseHeight / 2);
				CENTER.init($baseWidth / 2, $baseHeight / 2);
				
				_updateables = [TOP_LEFT, TOP_CENTER, TOP_RIGHT, RIGHT_CENTER, BOTTOM_RIGHT, BOTTOM_CENTER, BOTTOM_LEFT, LEFT_CENTER, CENTER].concat(_updateables);
				
				LiquidStage.stage.addEventListener(Event.RESIZE, update, false, 0, true);
				LiquidStage.stage.scaleMode = StageScaleMode.NO_SCALE;
				
				switch (LiquidStage.stage.align) {
					case StageAlign.TOP_LEFT:
						_xStageAlign = 0;
						_yStageAlign = 0;
						break;
					case "":
						_xStageAlign = 1;
						_yStageAlign = 1;
						break;
					case StageAlign.TOP:
						_xStageAlign = 1;
						_yStageAlign = 0;
						break;
					case StageAlign.BOTTOM:
						_xStageAlign = 1;
						_yStageAlign = 2;
						break;
					case StageAlign.BOTTOM_LEFT:
						_xStageAlign = 0;
						_yStageAlign = 2;
						break;
					case StageAlign.BOTTOM_RIGHT:
						_xStageAlign = 2;
						_yStageAlign = 2;
						break;
					case StageAlign.LEFT:
						_xStageAlign = 0;
						_yStageAlign = 1;
						break;
					case StageAlign.RIGHT:
						_xStageAlign = 2;
						_yStageAlign = 1;
						break;
					case StageAlign.TOP_RIGHT:
						_xStageAlign = 2;
						_yStageAlign = 0;
						break;
				}
				_initted = true;
				
				var o:Object;
				for (var i:int = _pending.length - 1; i > -1; i--) {
					o = _pending[i];
					addObject(o.object, o.primaryPoint, o.xStretchPoint, o.yStretchPoint, o.accordingToBase, o.duration, o.ease);
					_pending.splice(i, 1);
				}
				refreshLevels();
				
				_dispatcher.dispatchEvent(new Event(Event.INIT));
			}
		}
		
		public static function createPinPoint($x:Number, $y:Number, $parent:DisplayObject=null):PinPoint {
			return new PinPoint($x, $y, $parent || _stageBox);
		}
		
		public static function pinObjects($objects:Array, $point:PinPoint, $accordingToBase:Boolean=true, $duration:Number=0, $ease:Function=null):void {
			for (var i:uint = 0; i < $objects.length; i++) {
				addObject($objects[i], $point, null, null, $accordingToBase, $duration, $ease);
			}
		}
		
		public static function pinObject($object:DisplayObject, $point:PinPoint=null, $accordingToBase:Boolean=true, $duration:Number=0, $ease:Function=null):void {
			addObject($object, $point, null, null, $accordingToBase, $duration, $ease);
		}
		
		public static function stretchObject($object:DisplayObject, $primaryPoint:PinPoint=null, $xStretchPoint:PinPoint=null, $yStretchPoint:PinPoint=null, $accordingToBase:Boolean=true, $duration:Number=0, $ease:Function=null):void {
			addObject($object, $primaryPoint, $xStretchPoint, $yStretchPoint, $accordingToBase, $duration, $ease);
		}
		
		private static function addObject($object:DisplayObject, $primaryPoint:PinPoint, $xStretchPoint:PinPoint, $yStretchPoint:PinPoint, $accordingToBase:Boolean=true, $duration:Number=0, $ease:Function=null):void {
			if ($primaryPoint == null) {
				$primaryPoint = LiquidStage.NONE;
			}
			if ($xStretchPoint == null) {
				$xStretchPoint = LiquidStage.NONE;
			}
			if ($yStretchPoint == null) {
				$yStretchPoint = LiquidStage.NONE;
			}
			if (_initted) {
				var item:LiquidItem = findObject($object);
				if (item == null) {
					item = new LiquidItem($object, $primaryPoint, $xStretchPoint, $yStretchPoint, $accordingToBase, $duration, $ease);
					_items.push(item);
					_updateables.push(item);
				} else {
					item.init($primaryPoint, $xStretchPoint, $yStretchPoint, $accordingToBase, $duration, $ease);
				}
				refreshLevels();
				update();
			} else {
				_pending.push({object:$object, primaryPoint:$primaryPoint, xStretchPoint:$xStretchPoint, yStretchPoint:$yStretchPoint, accordingToBase:$accordingToBase, duration:$duration, ease:$ease});
			}
		}
		
		public static function releaseObject($object:DisplayObject):void {
			for (var i:int = _items.length - 1; i > -1; i--) {
				if (_items[i].target == $object) {
					_items.splice(i, 1);
				}
			}
			for (i = _updateables.length - 1; i > -1; i--) {
				if (_updateables[i] is LiquidItem && _updateables[i].target == $object) {
					_updateables.splice(i, 1);
				}
			}
		}
		
		public static function update($e:Event=null):void {
			var w:Number = LiquidStage.stage.stageWidth, h:Number = LiquidStage.stage.stageHeight;
			if (LiquidStage.minWidth != 999999 && w < LiquidStage.minWidth) {
				w = LiquidStage.minWidth;
			}
			if (LiquidStage.minHeight != 999999 && h < LiquidStage.minHeight) {
				h = LiquidStage.minHeight;
			}
			if (_xStageAlign == 1) {
				_stageBox.x = (TOP_RIGHT.x - w) / 2;
			} else if (_xStageAlign == 2) {
				_stageBox.x = TOP_RIGHT.x - w;
			}
			if (_yStageAlign == 1) {
				_stageBox.y = (BOTTOM_LEFT.y - h) / 2;
			} else if (_yStageAlign == 2) {
				_stageBox.y = BOTTOM_LEFT.y - h;
			}
			
			_stageBox.width = w;
			_stageBox.height = h;
			
			LiquidStage.stage.addChild(_stageBox);
			
			for (var i:int = _updateables.length - 1; i > -1; i--) {
				_updateables[i].update();
			}
			
			LiquidStage.stage.removeChild(_stageBox);
			_dispatcher.dispatchEvent(new Event(Event.RESIZE));
		}
		
		public static function refreshLevels():void { //nesting levels are extremely important in terms of the order in which we update LiquidItems and PinPoints...
			for (var i:int = _updateables.length - 1; i > -1; i--) {
				_updateables[i].refreshLevel();
			}
			_updateables.sortOn("level", Array.NUMERIC | Array.DESCENDING); //to ensure that nested objects are updated AFTER their parents.
			
			var curLevel:int = _updateables[0].level;
			var row:Array = [];
			var all:Array = [row];
			for (i = 0; i < _updateables.length; i++) {
				if (_updateables[i].level == curLevel) {
					row[row.length] = _updateables[i];
				} else {
					curLevel = _updateables[i].level;
					row = [_updateables[i]];
					all[all.length] = row;
				}
			}
			
			_updateables = [];
			for (i = 0; i < all.length; i++) {
				row = all[i];
				row.sortOn("nestedLevel", Array.NUMERIC | Array.DESCENDING);
				_updateables = _updateables.concat(row);
			}
		}
		
		public static function findObject($target:DisplayObject):LiquidItem {
			for (var i:uint = 0; i < _items.length; i++) {
				if (_items[i].target == $target) {
					return _items[i];
				}
			}
			return null;
		}
		
		public static function addPinPoint($p:PinPoint):void {
			_updateables.push($p);
		}
		
		public static function addEventListener($type:String, $listener:Function, $useCapture:Boolean=false, $priority:int=0, $useWeakReference:Boolean=false):void {
			_dispatcher.addEventListener($type, $listener, $useCapture, $priority, $useWeakReference);
		}
		public static function removeEventListener($type:String, $listener:Function, $useCapture:Boolean=false):void {
			_dispatcher.removeEventListener($type, $listener, $useCapture);
		}
		public static function get stageBox():Sprite {
			return _stageBox;
		}
		public static function get initted():Boolean {
			return _initted;
		}
	}
}
	
import flash.display.*;
import flash.geom.*;
import flash.events.Event;
import gs.utils.*;
import gs.utils.tween.*;
import gs.*;

internal class LiquidItem {
	private static var _nullPoint:Point; //To avoid errors where parameters require a Point and Flash won't allow simply null.
	
	private var _duration:Number;
	private var _ease:Function;
	private var _pin:PinPoint; //the point that the target's registration point should be pinned to (top left, top center, top right, bottom left, etc.)
	private var _xStretch:PinPoint; //the point (if any) that the target should be stretched to on the x-axis
	private var _yStretch:PinPoint; //the point (if any) that the target should be stretched to on the y-axis
	private var _pinOffset:Point; // offest pixels from the _pin point
	private var _xStretchOffset:Point; //offset pixels from the _xStretch point
	private var _yStretchOffset:Point; //offset pixels from the _yStretch point
	private var _regOffset:Point; //reflects the position of the registration point inside the bounds of the target. x and y represent the 1-based percent of the total width/height. So if the registration point is centered, this would be new Point(0.5, 0.5)
	private var _accordingToBase:Boolean; //If true, offset measurements should be based on the baseWidth and baseHeight as determined in LiquidStage.init(). Otherwise, they're based on the current stage size.
	private var _xRemainder:Number; //when we update(), we round x coordinate down to the closest pixel and store the remainder here so we can add it back on the next update to keep things from drifting.
	private var _yRemainder:Number; //when we update(), we round y coordinate down to the closest pixel and store the remainder here so we can add it back on the next update to keep things from drifting.
	private var _tween:TweenLite;
	
	public var pinMovement:Point;
	private var _parentMovement:Point;
	private var _needsFirstRender:Boolean;
	
	public var level:int = 0;// takes into consideration the nesting depth as well as the _pin.level, _xStretch.level, and _yStretch.level. (maximum depth is used)
	public var nestedLevel:int = 0; //ignores all other factors besides how deep the target is nested
	public var target:DisplayObject;
	
	public function LiquidItem($target:DisplayObject, $pin:PinPoint=null, $xStretch:PinPoint=null, $yStretch:PinPoint=null, $accordingToBase:Boolean=true, $duration:Number=0, $ease:Function=null) {
		this.target = $target;
		if (_nullPoint == null) {
			_nullPoint = LiquidStage.NONE;
		}
		init($pin, $xStretch, $yStretch, $accordingToBase, $duration, $ease);
	}
	
	public function init($pin:PinPoint, $xStretch:PinPoint=null, $yStretch:PinPoint=null, $accordingToBase:Boolean=true, $duration:Number=0, $ease:Function=null):void {
		_pin = $pin;
		_xStretch = $xStretch;
		_yStretch = $yStretch;
		_accordingToBase = $accordingToBase;
		_duration = $duration;
		_ease = $ease;
		_xRemainder = _yRemainder = 0;
		this.pinMovement = new Point(0, 0);
		initOffsets();
	}
	
	public function update():void {
		var p:DisplayObjectContainer = this.target.parent;
		if (p != null) {
			var pin:Point = _pin.global, xStretch:Point = _xStretch.global, yStretch:Point = _yStretch.global;
			var pinOld:Point, xStretchOld:Point, yStretchOld:Point;
			if (_needsFirstRender) {
				pinOld = _pin.baseGlobal;
				xStretchOld = _xStretch.baseGlobal;
				yStretchOld = _yStretch.baseGlobal;
				_needsFirstRender = false;
			} else {
				pinOld = _pin.previous;
				xStretchOld = _xStretch.previous;
				yStretchOld = _yStretch.previous;
			}
			if (this.target.parent != this.target.root) {
				pin = p.globalToLocal(pin);
				pinOld = p.globalToLocal(pinOld);
				if (_xStretch != _nullPoint) {
					xStretch = p.globalToLocal(xStretch);
					xStretchOld = p.globalToLocal(xStretchOld);
				}
				if (_yStretch != _nullPoint) {
					yStretch = p.globalToLocal(yStretch);
					yStretchOld = p.globalToLocal(yStretchOld);
				}
			}
			
			var x:Number = pin.x - pinOld.x + _xRemainder, y:Number = pin.y - pinOld.y + _yRemainder, width:Number = 0, height:Number = 0;
			
			if (_xStretch != _nullPoint) {
				width = (xStretch.x - pin.x) - (xStretchOld.x - pinOld.x);
				x += _regOffset.x * width;
			}
			if (_yStretch != _nullPoint) {
				height = (yStretch.y - pin.y) - (yStretchOld.y - pinOld.y);
				y += _regOffset.y * height;
			}
			
			this.pinMovement.x = int(x);
			this.pinMovement.y = int(y);
			
			if (_parentMovement != null) {
				x -= _parentMovement.x;
				y -= _parentMovement.y;
			}
			
			_xRemainder = x % 1;
			_yRemainder = y % 1;
			
			var tweens:Array = TweenLite.masterList[this.target], i:int, tween:TweenLite;			
			if (_duration != 0) {
				var createTweenX:Boolean = true, createTweenY:Boolean = true;
				if (tweens != null) {
					for (i = tweens.length - 1; i > -1; i--) {
						tween = tweens[i];
						if (tween != _tween && (tween.vars.x != null || tween.vars.y != null) && tween.startTime <= TweenLite.currentTime && tween.startTime + (tween.duration * 1000 / tween.combinedTimeScale) > TweenLite.currentTime) {
							if (tween.vars.x != null) {
								createTweenX = false; //don't create a new tween because there's already one active, so we'll simply adjust the end x value
							}
							if (tween.vars.y != null) {
								createTweenY = false; //don't create a new tween because there's already one active, so we'll simply adjust the end y value
							}
						}
					}
				}
				
				var obj:Object;
				if (_tween != null) {
					obj = _tween.vars;
					_tween.enabled = false; //kills the tween
					_tween.clear();
				} else {
					obj = this.target;
				}
				
				var vars:Object = {ease:_ease, delay:0.25, overwrite:0, onComplete:onCompleteTween};
				if (createTweenX) {
					vars.x = int(x) + obj.x;
				}
				if (createTweenY) {
					vars.y = int(y) + obj.y;
				}
				if (_xStretch != _nullPoint) {
					vars.width = width + obj.width;
				}
				if (_yStretch != _nullPoint) {
					vars.height = height + obj.height;
				}
				_tween = new TweenLite(this.target, _duration, vars);
				
			} else {
				this.target.x += int(x);
				this.target.y += int(y);
				if (xStretch != _nullPoint) {
					this.target.width += width;
				}
				if (yStretch != _nullPoint) {
					this.target.height += height;
				}
			}
			
			//look for other competing tweens (of x and y on this.target) and adjust their end values
			var ti:TweenInfo, j:int, time:Number, progress:Number, factor:Number, endValue:Number;
			if (tweens != null) {
				for (i = tweens.length - 1; i > -1; i--) {
					tween = tweens[i];
					
					if (tween != _tween && tween != null && (tween.vars.x != null || tween.vars.y != null)) {
						
						if (tween.vars.x != null) {
							tween.vars.x += int(x);
						}
						if (tween.vars.y != null) {
							tween.vars.y += int(y);
						}
						
						time = (tween.startTime != 999999999999999) ? TweenLite.currentTime : tween["pauseTime"];
						progress = (((time - tween.initTime) * 0.001) - tween.delay / tween.combinedTimeScale) / tween.duration * tween.combinedTimeScale;
						if (progress > 1) {
							progress = 1;
						} else if (progress < 0) {
							progress = 0;
						}
						factor = 1 / (1 - tween.ease(progress * tween.duration, 0, 1, tween.duration));
						
						for (j = tween.tweens.length - 1; j > -1; j--) {
							ti = tween.tweens[j];
							if (ti.property == "x" && ti.target == this.target && int(x) != 0) {
								ti.change += int(x);
								if (progress != 0) { //adjust starting values so that there's not a jump during the in-progress tween!
									endValue = ti.start + ti.change; 
									ti.change = (endValue - ti.target[ti.property]) * factor;
									ti.start = endValue - ti.change;
								}
							} else if (ti.property == "y" && ti.target == this.target && int(y) != 0) {
								ti.change += int(y);
								if (progress != 0) { //adjust starting values so that there's not a jump during the in-progress tween!
									endValue = ti.start + ti.change;
									ti.change = (endValue - ti.target[ti.property]) * factor;
									ti.start = endValue - ti.change;
								}
							}
							
						}
						
					}
				}
			}
			
			
		}
		
	}
	
	private function onCompleteTween():void {
		_tween = null;
	}
	
	private function onAddToStage($e:Event):void {
		this.target.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		initOffsets();
	}
	
	private function onLiquidStageInit($e:Event):void {
		LiquidStage.removeEventListener(Event.INIT, onLiquidStageInit);
		initOffsets();
	}
	
	private function initOffsets():void {
		if (!LiquidStage.initted) {
			LiquidStage.addEventListener(Event.INIT, onLiquidStageInit, false, 0, true);
		} else if (this.target.parent == null) {
			this.target.addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true);
		} else {
			
			LiquidStage.refreshLevels();
			//if (_pin == _nullPoint) {
				//_pin = getClosestPoint(this.target, _accordingToBase);
			//}
			var pin:Point, xStretch:Point, yStretch:Point;
			if (_accordingToBase) {
				pin = _pin.baseGlobal;
				xStretch = _xStretch.baseGlobal;
				yStretch = _yStretch.baseGlobal;
			} else {
				pin = _pin.global;
				xStretch = _xStretch.global;
				yStretch = _yStretch.global;
			}
			
			if (this.target.parent != this.target.root) {
				pin = this.target.parent.globalToLocal(pin);
				xStretch = this.target.parent.globalToLocal(xStretch);
				yStretch = this.target.parent.globalToLocal(yStretch);
			}
			_pinOffset = new Point(this.target.x - pin.x, this.target.y - pin.y);
			var b:Rectangle = this.target.getBounds(this.target);
			_regOffset = new Point(-b.x / b.width, -b.y / b.height);
			if (_xStretch != _nullPoint) {
				_xStretchOffset = new Point((this.target.x + ((1 - _regOffset.x) * this.target.width)) - xStretch.x, this.target.y - xStretch.y);
				_pinOffset.x -= _regOffset.x * this.target.width;
			}
			if (_yStretch != _nullPoint) {
				_yStretchOffset = new Point(this.target.x - yStretch.x, this.target.y + ((1 - _regOffset.y) * this.target.height) - yStretch.y);
				_pinOffset.y -= _regOffset.y * this.target.height;
			}
			if (_accordingToBase) {
				_needsFirstRender = true;
			}
			LiquidStage.update();
		}
	}
	
	public function refreshLevel():void {
		_parentMovement = null;
		this.nestedLevel = 0;
		var li:LiquidItem;
		var curParent:DisplayObject = this.target;
		while (curParent != this.target.stage) {
			this.nestedLevel += 2;
			li = LiquidStage.findObject(curParent.parent);
			if (li != null && _parentMovement == null) {
				_parentMovement = li.pinMovement;
			}
			curParent = curParent.parent;
		}
		var a:Array = [this.nestedLevel, _pin.level + 1, _xStretch.level + 1, _yStretch.level + 1]; //if one of the points has a higher level (updated later), we need to push this up one level higher than any of those so that it gives them a chance to update first.
		a.sort(Array.NUMERIC | Array.DESCENDING);
		this.level = a[0];
	}
	
}
