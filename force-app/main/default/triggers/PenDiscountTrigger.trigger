/*Client: Parker Company (Pens/Pencils)
Req: As this is 20th anniversary for Parker,
they want to give 20$ flat discount for any pen purchased above 100$.
*/

trigger PenDiscountTrigger on Parker_Pen__c (before insert ) {
    
    for(Parker_Pen__c p : Trigger.new){
        if(p.Price__c > 100){
            p.Price__c = p.Price__c - 20;  
            p.Discount_info__c ='20$ discount';
        }else{
            p.Discount_info__c ='No discount';
        }
    }
}