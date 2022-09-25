trigger customerDiscount on Mobile__c (Before insert,Before Update) 
{
    
    if(Trigger.isInsert==true && Trigger.isBefore==true)
    {
       discountclass.discountfunc(Trigger.new);  
    }
    
    if(Trigger.isUpdate==true && Trigger.isBefore==true)
    {
       discountclass.discountfunc2(Trigger.new);  
    }
}