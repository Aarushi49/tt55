trigger studenttrigger on Name__c(before insert,before update,before delete)
{
     if(trigger.isBefore==true && trigger.isInsert==true)
     {
        studentclass.student_func(Trigger.new);
        }
    
     if(trigger.isBefore==true && trigger.isUpdate==true)
     {
        studentclass.student_func(Trigger.new);
        }
    
    if(trigger.isBefore==true && trigger.isDelete==true)
     {
        studentclass.student_func3(Trigger.old);
        }

 }