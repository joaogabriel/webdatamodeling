/*
VERSION: 0.97
DATE: 9/9/2008
ACTIONSCRIPT VERSION: 3.0
UPDATES & MORE DETAILED DOCUMENTATION AT: http://blog.greensock.com/liquidstage/
DESCRIPTION:
	PinPoint works with LiquidStage to create custom points to which you can pin DisplayObjects. 
	See LiquidStage documentation for more information.


AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2008, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/

package gs.utils {
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public class PinPoint extends Point {
		public var global:Point;
		public var baseGlobal:Point;
		public var previous:Point;
		public var parent:DisplayObject;
		public var level:int = -1;
		public var nestedLevel:int = -1;
		
		public function PinPoint($x:Number, $y:Number, $parent:DisplayObject=null) {
			super($x, $y);
			if ($parent == null) {
				$parent = LiquidStage.stageBox;
			}
			this.parent = $parent;
			this.global = this.parent.localToGlobal(this);
			this.baseGlobal = this.global.clone();
			this.previous = this.global.clone();
			if (LiquidStage) { //the main static PinPoints in LiquidStage create instances before LiquidStage is fully available.
				refreshLevel();
				LiquidStage.addPinPoint(this);
			}
		}
		
		public function init($x:Number, $y:Number):void {
			this.x = $x;
			this.y = $y;
			var p:Point = this.parent.localToGlobal(this);
			this.global.x = this.baseGlobal.x = this.previous.x = int(p.x);
			this.global.y = this.baseGlobal.y = this.previous.y = int(p.y);
		}
		
		public function update():void {
			var p:Point = this.parent.localToGlobal(this);
			previous.x = global.x;
			previous.y = global.y;
			global.x = int(p.x);
			global.y = int(p.y);
		}
		
		public function refreshLevel():void {
			if (this.parent == LiquidStage.stageBox) {
				this.level = -1;
			} else if (this.parent.stage != null) {
				this.level = 1; //forces it to be 1 level higher than the LiquidItems which is necessary to have them refresh in the correct order.
				var curParent:DisplayObject = this.parent;
				while (curParent != this.parent.stage) {
					this.level += 2;
					curParent = curParent.parent;
				}
			}
		}
		
	}
}