public class fileUploadCustomClass {

@AuraEnabled
public static void insertRecords(String finalData) { 
    system.debug('data--'+finalData);
    List<Account> accList = new List<Account>();
    List<Contact> conList = new List<Contact>();

    fromJSON ff = new fromJSON();

    fromJSON wrapper = (fromJSON) JSON.deserializeStrict(finalData, fromJSON.class);
    system.debug('data--'+wrapper.Account);

    for(fromJSON.cls_Account s: wrapper.Account){
      Account acc= new Account( name=s.Name, Phone =s.Phone);
      accList.add(acc);
      system.debug('data- acc - '+acc);
    }

    if(accList.size() > 0 ){
       insert accList;
    }

    for(fromJSON.cls_Contact s: wrapper.Contact){
        Contact con= new Contact( lastname=s.Name, Email =s.Email);
        conList.add(con);
        system.debug('data- con - '+con);
      }
  
      if(conList.size() > 0 ){
         insert conList;
      }

    }
    
    //delete[Select id from account where createddate = today];
}