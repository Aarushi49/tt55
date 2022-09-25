import { LightningElement } from 'lwc';

export default class SelfCalculator extends LightningElement {
value1=100;
value2=100;
finalResult;


onChangeValue1(event){
this.value1 = event.target.value;
}

onChangeValue2(event){
this.value2 = event.target.value; 
}

add(){
this.finalResult = parseInt(this.value1) +parseInt(this.value2);
}

subtract(){
this.finalResult = parseInt(this.value1) - parseInt(this.value2);
}

multiply(){
this.finalResult = parseInt(this.value1) * parseInt(this.value2);
}

divide(){
this.finalResult = parseInt(this.value1) / parseInt(this.value2);
}


}