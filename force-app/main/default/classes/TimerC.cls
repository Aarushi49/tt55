public class TimerC {

    public Test__c tm {get;set;}
    
    public TimerC(){
        tm = new Test__c();
        tm = [SELECT Id, Duration__c FROM Test__c WHERE Duration__c=10];
    }
}