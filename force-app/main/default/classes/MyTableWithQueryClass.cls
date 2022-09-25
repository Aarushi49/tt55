public class MyTableWithQueryClass {

    public static list <Contact> ContactList {Get;Set;} 
    
//this is called as constructor, which gets called FIRST as soon as class is called by anyone.
    public MyTableWithQueryClass (){
        //nothing
        ContactList  = null;
    }
    
    public static void ShowData(){ 
        ContactList = [SELECT Name,Email FROM Contact WHERE email<> null LIMIT 10];          
    
    }

}