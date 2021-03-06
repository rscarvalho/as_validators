﻿import br.eti.rcarvalho.validators.TextValidator; 

class br.eti.rcarvalho.validators.CrosswordValidator{
    public var words:Object;
    private var textValidators:Array = new Array();
    
    public function CrosswordValidator(){
        trace("crossword!");
    }

    public function setUp(words:Object){
        this.words = (words) ? words : {};
        for(var word in this.words){
            var el = this.words[word];
            for(var i = 0; i < el.length; i++){
                textValidators.push(new TextValidator(el[i], word.charAt(i), {required: true}));
            }
        }
    }
    
    public function isValid():Boolean{
        trace("performin validation on " + textValidators);
        return TextValidator.validateAll(textValidators);
    }
}