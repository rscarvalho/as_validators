/*
* class TextValidator
* usage: new TextValidator(mc, test_string, [options]);
*/
class br.eti.rcarvalho.validators.TextValidator{
    private var target;
    private var required:Boolean = true;
    private var minLength:Number = -1;
    private var maxLength:Number = -1;
    private var testString:String = null;
    private var compType:String = "equals";
    private var ignoreCase:Boolean = true;
    private var ignoreSpecialChars:Boolean = false;
    
    function TextValidator(target, test_string, args){
        this.target = target;
        this.testString = test_string;
        setUp(args);
    }
    
    public function setUp(args){
        setIt(target, "_width", args.width);
        setIt(target, "_height", args.height);
        setIt(target, "maxChars", args.maxLength);
        
        for(var k in args){
            if(this.hasOwnProperty(k)){
                this[k] = args[k];
            }
        }
    }
    
    private function setIt(obj, name, value){
        if(value != null && value != undefined){
            obj[name] = value;
        }
    }
    
    public function isValid():Boolean{
        var txt:String = trim(target.text);
        var compString:String = testString;
        var valid:Boolean = true;
        if(required){
            valid = valid && (txt.length > 0);
        }
        
        if(minLength >= 0){
            valid = valid && (txt.length >= minLength);
        }
        
        if(maxLength >= 0){
            valid = valid && (txt.length <= maxLength);
        }
        
        var compString:String;
        var compText:String;
        if(ignoreCase){
            compString = testString.toLowerCase();
            compText = txt.toLowerCase();
        }else{
            compText = txt;
        }
        
        if(compString.length > 0){
            switch(compType){
                case "equals":
                    valid = valid && (compText == compString);
                case "contains":
                    valid = valid && (compText.indexOf(compString) >= 0);
                break;
                case "notcontains":
                    valid = valid && (compText.indexOf(compString) == -1);
                break;
                case "startswith":
                    valid = valid && (compText.indexOf(compString) == 0);
                break;
                case "endswith":
                    valid = valid && (compText.indexOf(compString) == (compText.length - 1));
                break
            }
        }
        
        return valid;
    }
    
    private function trim(str:String):String{
        var stripCharCodes = {
            code_9  : true, // tab
            code_10 : true, // linefeed
            code_13 : true, // return
            code_32 : true  // space
        };
        while(stripCharCodes["code_" + str.charCodeAt(0)] == true) {
            str = str.substring(1, str.length);
        }
        while(stripCharCodes["code_" + str.charCodeAt(str.length - 1)] == true) {
            str = str.substring(0, str.length - 1);
        }
        return str;
    }
    
    public static function validateAll(list):Boolean{
        
        var valid:Boolean = true;
        for(var i = 0; i < list.length; i++){
            if(!list[i].isValid()){
                trace(list[i] + " is invalid.");
            }
            trace("target: " + list[i].target);
            valid = valid && list[i].isValid();
        }
        trace("valid? " + valid);
        return valid;
    }
}