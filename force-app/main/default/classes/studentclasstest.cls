@isTest
class studentclasstest
{
    static testmethod void fuc11()
    {
        Name__c n=new Name__c();
        n.Age__c=22;
        n.Experience__c=12;
        
        insert n;
        
        n.Age__c=44;
        update n;
        
        Name__c n2=new Name__c();
        n2=[Select Status__c from Name__c where id=:n.Id];
        
        System.assertEquals('Not Selected', n2.Status__c);
        
    }
}