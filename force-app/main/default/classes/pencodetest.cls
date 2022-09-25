@istest
public class pencodetest {
    
    public static testmethod void test(){
        Parker_Pen__c pen=new Parker_Pen__c();
        pen.name='test';
        pen.Price__c=89;
        pen.Code__c=121;
        insert pen;
        system.debug('eeee'+pen);
       
    }
}