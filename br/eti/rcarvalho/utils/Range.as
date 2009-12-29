class br.eti.rcarvalho.utils.Range{
    private var begin:Number;
    private var end:Number;
    private var step:Number;
    
    public function Range(begin:Number, end:Number, step:Number){
        this.begin = begin;
        this.end = end;
        this.step = (step) ? step : 1;
    }
    
    public function toArray():Array{
        var a:Array = new Array();
        for(var i = begin; i < end; i++){
            a.push(i);
        }
        return a;
    }
    
    public function map(func:Function):Array{
        var a:Array = new Array();
        for(var i = begin; i < end; i++){
            a.push(func.call(this, i));
        }
        return a
    }
}