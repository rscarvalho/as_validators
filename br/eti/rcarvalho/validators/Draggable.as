import mx.transitions.easing.*;
import mx.transitions.Tween;

class br.eti.rcarvalho.validators.Draggable{
	public var draggable:MovieClip;
	public var droppable:MovieClip;
	public var onDrag:Function;
	public var onDrop:Function;
	public var backToPosition:Boolean = true;
	
	private var dragX:Number;
	private var dragY:Number;
	private var isDragging:Boolean = false;
	private var valid:Boolean = false;
	private var centerObject:Boolean = true;
	
	function Draggable(draggable:MovieClip, droppable:MovieClip, centerObject:Boolean){
		trace("setting up draggable for " + this.draggable + " => " + this.droppable);
		this.draggable = draggable;
		this.droppable = droppable;
		
		if(centerObject != null){
			this.centerObject = centerObject;
		}
		
		setUp();
	}
	
	function setUp(){
		var _self = this;
		var oldRelease:Function = draggable.onRelease;
		draggable.onRelease = function(){
			
			if(_self.isDragging){
				stopDrag();
				_self.isDragging = false;
				
				if(_self.droppable == null || eval(this._droptarget) != _self.droppable){
					trace("turning back...");
					new Tween(this, "_x", Strong.easeOut, this._x, _self.dragX, 5);
					new Tween(this, "_y", Strong.easeOut, this._y, _self.dragY, 5);
				}else{
					_self.valid = true;
					trace("active!");
					
					if(_self.centerObject){
						var px = _self.droppable._x - 2 + (_self.droppable._width - this._width)/2;
						var py = _self.droppable._y - 2 + (_self.droppable._height - this._height)/2;
						
						new Tween(this, "_x", Strong.easeOut, this._x, px, 2);
						new Tween(this, "_y", Strong.easeOut, this._y, py, 2);
					}
				}
			}
			
			if(oldRelease){
				oldRelease.call(this);
			}
		}
		
		draggable.onReleaseOutside = draggable.onRelease;
		
		var oldPress:Function = draggable.onPress;
		draggable.onPress = function(){
			if(this._droptarget != droppable){
				_self.isDragging = true;
				_self.dragX = this._x;
				_self.dragY = this._y;
				startDrag(this);
			}
			
			if(oldPress){
				oldPress.call(this);
			}
		}
	}
	
	function isValid():Boolean{
		return this.valid || (droppable == eval(draggable._droptarget));
	}
	
	public static function validateAll(objects:Array){
		var _valid = true;
		for(var i = 0; i < objects.length; i++){
			if(!objects[i].isValid()){
				trace(objects[i].draggable._name + " is invalid. " + objects[i].droppable._name + " != " + eval(objects[i].draggable._droptarget)._name);
			}
			_valid = _valid && objects[i].isValid();
		}
		return _valid;
	}
}
