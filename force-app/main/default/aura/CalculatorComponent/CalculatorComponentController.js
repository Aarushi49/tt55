({
    doAdd : function(component, event, helper) {
        var compInQues1 = component.find('input1');
        var a1 = compInQues1.get('v.value');
        var compInQues2 = component.find('input2');
        var a2 = compInQues2.get('v.value');
        var result= parseFloat(a1) +parseFloat(a2);
        var resultComp = component.find('input3');
        resultComp.set('v.value',result);

    },
    doSub : function(component, event, helper) {
        var compInQues1 = component.find('input1');
        var a1 = compInQues1.get('v.value');
        var compInQues2 = component.find('input2');
        var a2 = compInQues2.get('v.value');
        var result= parseFloat(a1) - parseFloat(a2);
        var resultComp = component.find('input3');
        resultComp.set('v.value',result);
	},
 	doDiv : function(component, event, helper) {
        var compInQues1 = component.find('input1');
        var a1 = compInQues1.get('v.value');
        var compInQues2 = component.find('input2');
        var a2 = compInQues2.get('v.value');
        var result= parseFloat(a1) / parseFloat(a2);
        var resultComp = component.find('input3');
        resultComp.set('v.value',result);
	},
	doMult : function(component, event, helper) {
        var compInQues1 = component.find('input1');
        var a1 = compInQues1.get('v.value');
        var compInQues2 = component.find('input2');
        var a2 = compInQues2.get('v.value');
        var result= parseFloat(a1) * parseFloat(a2);
        var resultComp = component.find('input3');
        resultComp.set('v.value',result);
	}
})