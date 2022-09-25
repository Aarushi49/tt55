public with sharing class classVF {
    public String accname {get;set;}
    list<Account>lstacc= new list<Account>();
    list<contact>lstcon = new List<contact>();
    public List<contact> getContacts(){
        lstcon.clear();
        accIds.clear();
        lstacc.clear();
        lstacc=[Select id,name from Account where name= :accName];
        for(Integer i =0; i<lstacc.size(); i++)
        {
            accIds.add(lstacc[i].id);
           
        }
        lstcon = [select id,name,Phone,email,accountId from contact where accountid in : accIds];
        return lstcon;
    }
    set<string> accIds = new set<string>();
    public pagereference showContacts(){
        return null;
    }
}