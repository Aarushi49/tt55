trigger Capacitycheck on Series__c(Before insert,before update) 
{
    
    if((Trigger.isInsert==true && Trigger.isbefore==true) || (Trigger.isUpdate==true && Trigger.isbefore==true))
    {
        capacitycheckclass.capacityfunc(Trigger.new);
    }

}