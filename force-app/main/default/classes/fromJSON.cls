public class fromJSON{
    public cls_Account[] Account;
    public cls_Contact[] Contact;
    public cls_Sheet3[] Sheet3;

    public class cls_Account {
        public String Name;	//Test1
        public String Phone;	//test1@gmail.com
    }
    public class cls_Contact {
        public String Name;	//aa1
        public String Email;	//aa1@gmail.com 
    }
    
    public class cls_Sheet3 {
    }
    public fromJSON parse(String json){
        return (fromJSON) System.JSON.deserialize(json, fromJSON.class);
    }

}