import { LightningElement } from 'lwc';

export default class NewLwcComp extends LightningElement {

number1;
number2;
Result;

handleChange(event){
const val =event.target.value;
const name = event.target.name;

if(name == 'number1'){
this.number1 = val;
}else{
this.number2 = val;
}
}

doSum(){
this.Result = parseInt(this.number1) + parseInt(this.number2);
}
doMultiply(){
this.Result = parseInt(this.number1) * parseInt(this.number2);
}
doSubtract(){
this.Result = parseInt(this.number1) - parseInt(this.number2);
}
doDivision(){
    this.Result = parseInt(this.number1)/ parseInt(this.number2);
}
}