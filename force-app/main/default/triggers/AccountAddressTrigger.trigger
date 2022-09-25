trigger AccountAddressTrigger on Account (before insert,before update) {
    if(trigger.isbefore && (trigger.isinsert || trigger.isupdate)){
        for(Account acc : trigger.new){
            if(String.isNotBlank(acc.BillingPostalCode) && acc.Match_Billing_Address__c == true){
                acc.ShippingPostalCode =acc.BillingPostalCode;
            }
        }
        
    }

}