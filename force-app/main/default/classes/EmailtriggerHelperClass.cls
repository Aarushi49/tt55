public class EmailtriggerHelperClass {
    public static void helperMethodA(list<Contact> conlist){
        for(Contact con:conlist){   
            if(con.email == null && con.lastname != null){
                con.email= con.lastname + '@test.com';
            }
            if(con.Languages__c == null){
                con.Languages__c ='English';
            }
        }
    }
    
}