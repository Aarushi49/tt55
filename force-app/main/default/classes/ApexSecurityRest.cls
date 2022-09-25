@RestResource(urlMapping='/apexSecurityRest')
global with sharing class ApexSecurityRest {
    @HttpGet
    global static Contact doGet() {
        Id recordId = RestContext.request.params.get('id');
        Contact result;
        if (recordId == null) {
            throw new FunctionalException('Id parameter is required');
        }
        List<Contact> results = [SELECT Id,Name, Title, Top_Secret__c, Account.Name FROM Contact WHERE Id = :recordId];
        system.debug('iiii---'+results);
        SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.READABLE, results);
        
        result.Description = results[0].Account?.Name;
        return result;
        
    }
    public class FunctionalException extends Exception{}
    public class SecurityException extends Exception{}
}