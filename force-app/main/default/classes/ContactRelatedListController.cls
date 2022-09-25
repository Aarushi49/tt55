public class ContactRelatedListController {     

    public List<contact> contacts{get;set;} 

    public Account accounts {get;set;} 

    public Account acc {get;set;} 
 public  static string acc2;
     

    //Constructor 

    public ContactRelatedListController(ApexPages.StandardController controller) { 

        acc = (account)controller.getRecord();      
        acc2=ApexPages.currentPage().getParameters().get('id');
        system.debug('id2 is'+ApexPages.currentPage().getUrl());
        accounts = [SELECT id FROM account WHERE id=: acc.id LIMIT 1]; 
        system.debug('id is '+acc2);
        contacts = [SELECT id,Name, mobilephone, email FROM contact WHERE accountid = :accounts.id ORDER BY Name];     

} 

    //This method is to create a new contact while clicking on the Add contact button 

    public pageReference newContact(){  

        pageReference pageRef = new pageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/003/e?&retURL=' + accounts.id);  

        return pageRef; 

    } 

    //This method is to edit the existing contact record while clicking the Edit link 

    public pageReference editContact(){  
            system.debug('id2eeeeeeee is'+ApexPages.currentPage().getUrl());

system.debug('ideeeeeeeee is '+acc2);
        String contactId = Apexpages.currentpage().getParameters().get('contactId');  

        pageReference pageRef = new pageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + contactId + '/e?retURL=' + accounts.id);  

        return pageRef;  

    }    


 //This method is to delete the contact record while clicking the Del link 

    public pageReference deleteContact(){  

        String contactId = Apexpages.currentpage().getParameters().get('contactId');  
            system.debug('qqqdelete'+contactId);


        contact contactList = [SELECT Id FROM contact WHERE id = : contactId LIMIT 1]; 

        delete contactList; 

        String baseUrl = URL.getSalesforceBaseUrl().toExternalForm(); 

        PageReference redirectPage = new PageReference(baseUrl+'/'+accounts.id); 

        return redirectPage;  

    }   

}