public class contactHandler {
    @AuraEnabled
    public static List<Contact> fetchContact(String recordId) {
       
        List<Contact> conList = [Select FirstName, LastName from Contact where AccountId = :recordId];
        System.debug(recordId + ' '+conList);
        return conList;
    }
    @AuraEnabled
    public static void saveContacts(List<Contact> conList) {
        update conList;
    }
    @AuraEnabled
    public static void deleteContacts(List<String> conIdList) {
        List<Contact> conList = [Select Id, Name from Contact where Id in :conIdList];
        delete conList;
    }
}