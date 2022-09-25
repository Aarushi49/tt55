public class contactcontroller {
    public contact con {get;set;}
    public  contactcontroller () {
        con = new contact ();
        //con=[select id, firstname,lastname,email,phone from contact limit 1];
    }
    
    
    public void savecontact(){
        system.debug('checkcon--'+con);
        upsert con;
       
    }
}