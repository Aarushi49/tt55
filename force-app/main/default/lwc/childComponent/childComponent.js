import { LightningElement } from 'lwc';

export default class ChildComponent extends LightningElement {

    handleEvent(){

        const eventSA = new CustomEvent('simpleevent');
        this.dispatchEvent(eventSA);
    }
    
}