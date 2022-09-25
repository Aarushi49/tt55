@isTest
public class AccountNContactTriggerTestClass {
    
    public static testmethod void method1(){
        Account acc = new Account();
        acc.Name='TestAccRelated';
        insert acc;
        
        Contact con1 = new contact();
        con1.email='testContact@3iz.net';
        con1.Company__c='TestAccRelated';
        con1.lastname='Testcon';
        insert con1;
        
    }
}